class Notification < ActiveRecord::Base
  attr_accessible :page_id,:title,:recipients,:sound,:badge

  after_create :send_notification


  def send_notification

    pusher = Grocer.pusher(
        certificate: File.join(Rails.root,"db/certificates/mychorescert.pem"),
        gateway:     "gateway.sandbox.push.apple.com", # optional; See note below.
        port:        2195,
        retries:     5                         # optional
    )

    deviceIds = Array.new
    searchParams = JSON.parse(recipients)

    if searchParams['all'] == "1"
      deviceIds = Device.where(:active => true)
    elsif searchParams['devices'] != ''
      #have to split them
      deviceIds = searchParams['devices'].split(",").each {|t| t.strip!}
      deviceIds = Device.find_all_by_identifier(deviceIds,:conditions => {active:true})

    else
      #start Searching....
      @users = User.scoped
      @users = @users.where(:id => Kid.where(:age => searchParams['ages'].to_i).select(:user_id).group(:user_id).map(&:user_id)) unless searchParams['ages'].blank?
      @users = @users.where(:id => Chore.where(:local_chore_id => searchParams['chore'].to_i).select(:user_id).group(:user_id).map(&:user_id)) unless searchParams['chore'].blank?
      @users = @users.where(:country => searchParams['country']) unless searchParams['country'].blank?
      @users = @users.where(:language => searchParams['language']) unless searchParams['language'].blank?

      if !@users.empty?
        @users.each do |u|
          deviceIds << u.devices.where(:active => true) .first

        end
      end
    end



    deviceIds.flatten.each do |device|
      PageUser.where(:user_id => device.user_id, :device_token => device.identifier,:page_id => page_id).first_or_create unless page_id.blank?

      #rich = PageUser.create(:user_id => user.id, :device_token => device,:page_id => page_id) unless page_id.blank?

      notification = Grocer::Notification.new(
          device_token: device.identifier,
          alert: { "body" =>  title}
      )

      notification.custom = {:acme2 => ["new message", "1"],:message_title => title} unless page_id.blank?

      notification.sound = 'default'
      notification.badge = badge.to_i unless badge.blank?


      pusher.push(notification)
    end
  end



end
