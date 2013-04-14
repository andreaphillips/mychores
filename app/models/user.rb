class User < ActiveRecord::Base
  attr_accessible  :email, :first_name, :last_name, :pass_code, :country, :language

  has_many :kids
  has_many :page_users, :dependent => :destroy
  has_many :pages, :through => :page_users
  has_many :devices
  has_many :chores

  validates :email, :presence => true
  validates_uniqueness_of :email, :case_sensitive => false

  after_create :send_welcome_email
  before_destroy :delete_kids

  def send_welcome_email
    Mailer.signup_notification(self).deliver
  end
  def forgot_passcode_mail
    Mailer.forgot_passcode(self).deliver
  end
  def find_chore_connections
    choreConnections = Array.new
    kids.each do |k|
      choreConnections.push( k.find_chore_connections )
    end
    return choreConnections.flatten
  end

  def find_chore_connections_since(date)
    choreConnections = Array.new
    kids.each do |k|
      choreConnections.push( k.kid_find_chore_connections_since(date))
    end
    return choreConnections.flatten
  end

  def send_welcome_push
    page = Page.find_by_name('Welcome!')
    puts "after create send welcome push"
    PageUser.create(:user_id => id, :device_token => self.devices.first.identifier,:page_id => page.id) unless page.nil? || self.devices.first.identifier.nil?
  end

end
