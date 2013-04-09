class Device < ActiveRecord::Base
  attr_accessible :identifier, :active
  belongs_to :user
  has_many :page_users, :dependent => :destroy
  has_many :pages, :through => :page_users

  before_create :inactivate_others
  after_create :send_welcome_push

  def inactivate_others
    others = Device.find_all_by_identifier(identifier)
    if !others.empty?
      others.each do |o|
        other = Device.find(o.id)
        other.active = false
        other.save
      end
    end
  end

  def send_welcome_push
    pusher = Grocer.pusher(
        certificate: File.join(Rails.root,"db/certificates/mychorescert.pem"),
        gateway:     "gateway.sandbox.push.apple.com", # optional; See note below.
        port:        2195,
        retries:     5                         # optional
    )
    page = Page.find_by_name('Welcome!')
    puts "after create send welcome push"
    puts identifier

    PageUser.create(:user_id => user_id, :device_token => identifier,:page_id => page.id) unless page.nil?
    if !identifier.include?('nopush')
      notification = Grocer::Notification.new(
          device_token: identifier,
          alert: { "body" =>  "Welcome to MyChores!"}
      )
      notification.custom = {:acme2 => ["new message", "1"]}
      notification.sound = 'default'
      pusher.push(notification)
    end
  end
end
