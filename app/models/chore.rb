class Chore < ActiveRecord::Base
  attr_accessible :chore, :local_chore_id, :user_id, :picture
  has_many :chore_kids
  belongs_to :user

end
