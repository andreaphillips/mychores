class Device < ActiveRecord::Base
  attr_accessible :identifier
  belongs_to :user
  has_many :page_users, :dependent => :destroy
  has_many :pages, :through => :page_users

  after_create :inactivate_others,:send_welcome_push

  def inactivate_others
    others = Device.find_by_identifier(identifier)
    if !others.nil?
      others.update_attribute(:active,false)
    end
    self.active = true
    self.save
  end

  def send_welcome_push
    pusher = Grocer.pusher(
        certificate: File.join(Rails.root,"db/certificates/mychorescert.pem"),
        gateway:     "gateway.sandbox.push.apple.com", # optional; See note below.
        port:        2195,
        retries:     5                         # optional
    )
    page = Page.find_by_name('Welcome!')
    PageUser.create(:user_id => user_id, :device_token => identifier,:page_id => page.id) unless page.nil?
    notification = Grocer::Notification.new(
        device_token: identifier,
        alert: { "body" =>  "Welcome to MyChores!"}
    )
    notification.custom = {:acme2 => ["new message", "1"]}
    notification.sound = 'default'
    pusher.push(notification)
  end
end
