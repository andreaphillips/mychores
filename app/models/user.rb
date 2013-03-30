class User < ActiveRecord::Base
  attr_accessible  :email, :first_name, :last_name, :pass_code, :country, :language

  has_many :kids
  has_many :page_users, :dependent => :destroy
  has_many :pages, :through => :page_users
  has_many :devices

  validates :email, :presence => true
  validates_uniqueness_of :email
  #after_create :send_welcome_email
  before_destroy :delete_kids

  def send_welcome_email
    Mailer.signup_notification(self).deliver
  end




end
