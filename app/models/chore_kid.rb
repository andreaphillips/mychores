class ChoreKid < ActiveRecord::Base
  attr_accessible :begin, :end ,:kid_id, :chore_id
  belongs_to :chore
  belongs_to :kid

end
