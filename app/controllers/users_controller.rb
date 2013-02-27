class UsersController < ApplicationController
  skip_before_filter  :verify_authenticity_token

  def create

    @user = User.new(params[:user])

    if @user.save
      #@user.send_welcome_email
      render :json => @user
    else
      render :json => {:error => @user.errors}
    end
  end

  def edit
    if params[:id]
      @user = User.find(params[:id])
      if @user
        render :json => @user
      else
        render :json => {:error => @user.errors}
      end

    else
      render :json => {:error => 'need an id'}
    end
  end

  def delete
    if params[:id]
      @user = User.find(params[:id])
      @user.destroy
      if @user.destroyed?
        render :json => {:success => "user destroyed"}
      else
        render :json => {:error => @user.errors}
      end

    else
      render :json => {:error => 'need an id'}
    end
  end

  def show
    if params[:id]
      @user = User.find(params[:id])
      if @user
        render :json => {:success => "user destroyed"}
      else
        render :json => {:error => @user.errors}
      end
    else
      render :json => {:error => 'need an id'}
    end
  end

  def get_messages
    @user = User.find(params[:id])
    @messages = @user.pages.all(:conditions => 'read = false')
    pu = @user.page_users
    pu.each do |p|
      PageUser.find(p.id).update_attribute('read',true)
    end
    render :json => @messages
  end

end
