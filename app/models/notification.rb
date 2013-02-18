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
      deviceIds = User.select(:cloud_id).map(&:cloud_id)
    elsif searchParams['devices'] != ''
      #have to split them
      deviceIds = searchParams['devices']

    else
      #start Searching....
      @users = User.scoped
      @users = @users.where(:id => Kid.where(:age => searchParams['ages'].to_i).select(:parent_id).group(:parent_id).map(&:parent_id)) unless searchParams['ages'].blank?
      @users = @users.where(:id => Chore.where(:local_chore_id => searchParams['chore'].to_i).select(:parent_id).group(:parent_id).map(&:parent_id)) unless searchParams['chore'].blank?
      @users = @users.where(:country => searchParams['country']) unless searchParams['country'].blank?
      @users = @users.where(:language => searchParams['language']) unless searchParams['language'].blank?

      @users.each do |u|
        deviceIds << u.cloud_id
      end
    end




    deviceIds.each do |device|
      user = User.find_by_cloud_id(device)

      PageUser.create(:user_id => user.id, :device_token => device,:page_id => page_id) unless page_id.blank?

      notification = Grocer::Notification.new(
          device_token: device,
          alert: { "body" =>  title}
      )

      notification.custom = {:acme2 => ["new message", "1"]}

      notification.sound = sound unless sound.blank?
      notification.badge = badge.to_i unless badge.blank?


      pusher.push(notification)
    end
  end



end
