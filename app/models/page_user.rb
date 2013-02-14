class PageUser < ActiveRecord::Base
  attr_accessible :device_token, :page_id, :read, :deleted
  validates :device_token, :presence => true
  validates :page_id, :presence => true

end
