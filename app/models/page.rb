class Page < ActiveRecord::Base
  attr_accessible :name, :content
  has_many :page_users
  has_many :users, :through => :page_users

  def has_been_downloaded
    page_users.update_attribute("read", true)
  end

end
