class Notification < ActiveRecord::Base
  attr_accessible :page_id,:title,:recipients,:sound,:badge

  after_create :send_notification


  def send_notification
    pusher = Grocer.pusher(
        certificate: "db/certificates/mychorescert.pem",      # required
        retries:     3                         # optional
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
          badge:        badge
      )

      pusher.push(notification)
    end


  end



end
