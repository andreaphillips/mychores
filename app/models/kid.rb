class Kid < ActiveRecord::Base
  attr_accessible :age, :chore_amount, :name, :parent_id, :picture, :reward_percent, :sex,:local_id
end
