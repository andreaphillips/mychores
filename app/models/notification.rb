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
    end
    puts "pushing"
    puts deviceIds
    deviceIds.each do |device|
      puts "pushing each"
      notification = Grocer::Notification.new(
          device_token: device,
          alert:        title,
      )

      if sound != ''
        notification.sound = sonido
      end

      if badge != ''
        notification.badge = badge
      end

      pusher.push(notification)
    end


  end



end
