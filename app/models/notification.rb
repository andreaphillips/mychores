class Notification < ActiveRecord::Base
  attr_accessible :page_id,:title,:recipients,:sound,:badge

  after_create :send_notification


  def send_notification
    pusher = Grocer.pusher(
        certificate: "public/certificates/mychorescert.pem",      # required
        gateway:     "sandbox.push.apple.com", # optional; See note below.
        port:        2195,                     # optional
        retries:     3                         # optional
    )

    deviceIds = Array.new
    searchParams = JSON.parse(recipients)

    if searchParams['all'] == "1"
      deviceIds = Users.select(:cloud_id).map(&:cloud_id)
    end

    deviceIds.each do |device|

      notification = Grocer::Notification.new(
          device_token: device,
          alert:        title,
          badge:        badge
      )

      pusher.push(notification)
    end


  end



end
