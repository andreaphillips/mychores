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
end
