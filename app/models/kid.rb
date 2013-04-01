class Kid < ActiveRecord::Base
  attr_accessible :age, :chore_amount, :name, :picture, :reward_percent, :sex,:local_id
  belongs_to :user
  has_many :points, :dependent => :destroy
  has_many :chore_kids, :dependent => :destroy

  def points
    Point.where(:kid_id => self.id)
  end

  def find_chore_connections
    ch_connections = Array.new
    ch_connection = ChoreKid.find_all_by_kid_id(id)
    ch_connection.each do |c|

      toPush = Hash.new
      toPush['kid_id'] = Kid.find(c.kid_id).local_id
      toPush['chore'] = c.chore_id
      toPush['begin_date'] = c.begin
      toPush['end_date'] = c.end
      ch_connections.push(toPush)
    end
    return ch_connections
  end
  def find_chore_connections_since(date)
    ch_connections = Array.new
    ch_connection = ChoreKid.find_all_by_kid_id(id,:conditions=>['updated_at > ?',date])
    ch_connection.each do |c|

      toPush = Hash.new
      toPush['kid_id'] = Kid.find(c.kid_id).local_id
      toPush['chore'] = c.chore_id
      toPush['begin_date'] = c.begin
      toPush['end_date'] = c.end
      ch_connections.push(toPush)
    end
    return ch_connections
  end
end
