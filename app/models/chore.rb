class Chore < ActiveRecord::Base
  attr_accessible :chore, :local_chore_id, :parent_id
end
