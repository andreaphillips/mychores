class Point < ActiveRecord::Base
  attr_accessible :kid_id, :chore_id,:date, :points, :parent_id
end
