class Device < ActiveRecord::Base
  attr_accessible :identifier, :active
  belongs_to :user
  has_many :page_users, :dependent => :destroy
  has_many :pages, :through => :page_users

  before_create :inactivate_others
  #after_create :send_welcome_push

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

end
