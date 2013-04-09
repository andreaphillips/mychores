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
    page = Page.find_by_name('Welcome!')
    puts "after create send welcome push"
    puts identifier
    PageUser.create(:user_id => user_id, :device_token => identifier,:page_id => page.id) unless page.nil?
  end
end
