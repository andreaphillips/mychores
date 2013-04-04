class UsersController < ApplicationController
  skip_before_filter  :verify_authenticity_token

  def create
    @user = User.new(params[:user])
    @user.devices << Device.new(identifier: params[:device])

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

  def check
    @user = User.find_by_email(params[:user][:email])
    if @user.nil?
      render :json => {:error=> "User doesn't exist"}
    elsif @user.pass_code != params[:user][:pass_code].to_i
      render :json => {:error => "Passcode is Incorrect!"}
    else
      if !@user.devices.map(&:identifier).include?(params[:user][:device_id])
        @user.devices << Device.new(identifier: params[:user][:device_id])
      end
      render :json => @user
    end

  end

  def check_updates
   @user = User.find(params[:id])
   @kids = @user.kids
   @points = Point.for_json(@user.id)
   @chores = @user.chores
   @chores_connections = @user.find_chore_connections

   render :json => {:user => @user, :kids => @kids, :points => @points, :chores => @chores, :connections => @chores_connections}
  end

  def check_updates_since
    #created at
    since = params[:since].to_datetime
    @user = User.find(params[:id])
    @kids = @user.kids.where('updated_at > ?',since)
    @points = Point.for_json_since(@user.id,since)
    @chores = @user.chores.where('updated_at > ?',since)
    @chores_connections = @user.find_chore_connections_since(since)

    render :json => {:kids => @kids, :points => @points, :chores => @chores, :connections => @chores_connections}
  end

  def forgot_passcode
    @user = User.find(params[:id])

    if Mailer.forgot_passcode(@user).deliver
      render :json => {:status => "ok"}
    else
      render :json => {:status => 'ERROR'}
    end

  end

  def get_messages
    @unread = PageUser.find_all_by_device_token(params[:id],:conditions => {:created_at => 1.week.ago..1.second.ago} )
    @messages = PageUser.unread_messages(params[:id])
    @unread.each do |p|
      PageUser.find(p.id).update_attribute('read',true)
    end
    render :json => @messages
  end

end
