class Users < ActiveRecord::Base
  attr_accessible :cloud_id, :email, :fb_user, :first_name, :last_name, :pass_code

  validates :email, :presence => true
end
