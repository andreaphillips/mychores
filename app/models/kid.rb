class Kid < ActiveRecord::Base
  attr_accessible :age, :chore_amount, :name, :picture, :reward_percent, :sex,:local_id
  belongs_to :user
  has_many :points, :dependent => :destroy

  def points
    Point.where(:kid_id => self.id)
  end
end
