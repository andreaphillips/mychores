class Chore < ActiveRecord::Base
  attr_accessible :chore, :local_chore_id, :user_id, :picture
end
