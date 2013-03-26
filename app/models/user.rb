class User < ActiveRecord::Base
  attr_accessible :cloud_id, :email, :fb_user, :first_name, :last_name, :pass_code, :country, :language

  has_many :kids, :dependent => :destroy
  has_many :page_users, :dependent => :destroy
  has_many :pages, :through => :page_users

  validates :email, :presence => true
  #after_create :send_welcome_email
  after_create :send_welcome_push

  def send_welcome_email
    Mailer.signup_notification(self).deliver
  end

  def send_welcome_push
    pusher = Grocer.pusher(
        certificate: File.join(Rails.root,"db/certificates/mychorescert.pem"),
        gateway:     "gateway.sandbox.push.apple.com", # optional; See note below.
        port:        2195,
        retries:     5                         # optional
    )

    page = Page.find_by_name('Welcome!')

    PageUser.create(:user_id => id, :device_token => cloud_id,:page_id => page.id) unless page.nil?

    notification = Grocer::Notification.new(
        device_token: cloud_id,
        alert: { "body" =>  "Welcome!"}
    )

    notification.custom = {:acme2 => ["new message", "1"]}

    notification.sound = 'siren.aiff'


    pusher.push(notification)


  end

end
