class Point < ActiveRecord::Base
  attr_accessible :chore_id,:date, :points
  belongs_to :kid
end
