class UsersController < ApplicationController
  skip_before_filter  :verify_authenticity_token

  def create
    @user = User.create(params[:user])

    device = params[:device] == 'nopush' ? params[:device]+@user.id.to_s : params[:device]
    @user.devices << Device.new(identifier: device, active:true)

    if @user
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
        device = params[:user][:device_id] == 'nopush' ? 'nopush'+@user.id.to_s : params[:user][:device_id]
        if !@user.devices.map(&:identifier).include?(device)
          @user.devices << Device.create(identifier: device,active:true)
        else
          devi = @user.devices.where(:identifier => device).last
          others = Device.find_all_by_identifier(device)
          others.each do |o|
            o.update_attribute(:active,false)
          end
          devi.update_attribute(:active,true)
        end

      else
        dev = @user.devices.where(:identifier => params[:user][:device_id]).last
        others = Device.find_all_by_identifier(params[:user][:device_id])
        others.each do |o|
          o.update_attribute(:active,false)
        end
        dev.update_attribute(:active,true)
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
    @user_device = Device.find_all_by_identifier(params[:id], :conditions => {:active => true}).last
    @messages = PageUser.unread_messages(@user_device.user_id,params[:id])
    render :json => @messages
  end

  def message_read
    m = PageUser.find(params[:id]).update_attribute(:read,true)
    render :json => {:status => "ok"}

  end

  def message_deleted
    m = PageUser.find(params[:id])
    m.deleted = true
    m.save
    render :json => {:status => "ok"}
  end

end
