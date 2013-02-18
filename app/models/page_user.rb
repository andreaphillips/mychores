class PageUser < ActiveRecord::Base
  attr_accessible :device_token, :page_id, :read, :deleted, :user_id
  belongs_to :user, :foreign_key => :user_id
  belongs_to :page

end
