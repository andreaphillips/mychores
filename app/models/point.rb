class Point < ActiveRecord::Base
  attr_accessible :chore_id,:date, :points
  belongs_to :kid

  def self.for_json(user)
    points = Point.find_all_by_user_id(user)
    new_points = Array.new

    points.each do |p|
      point = Hash.new

      point['chore_id'] = p.chore_id
      point['points'] = p.points
      point['user_id'] = p.user_id
      point['date'] = p.date
      point['kid_id'] = p.kid.local_id

      new_points.push(point)
    end
    return new_points
  end

  def self.for_json_since(user,date)
    points = Point.find_all_by_user_id(user, :conditions => ["updated_at > ?",date])
    new_points = Array.new

    points.each do |p|
      point = Hash.new

      point['chore_id'] = p.chore_id
      point['points'] = p.points
      point['user_id'] = p.user_id
      point['date'] = p.date
      point['kid_id'] = p.kid.local_id

      new_points.push(point)
    end
    return new_points
  end

end
