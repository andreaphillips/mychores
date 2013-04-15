class Reward < ActiveRecord::Base
  attr_accessible :reward, :begin, :end
  belongs_to :kid

  def self.get_from_ids(ids)
    rewards = []
    ids.each do |id|
      kid = Kid.find(id)
      kid.rewards.each do |r|
        result = Hash.new
        result['kid_id'] = kid.local_id
        result['reward'] = r.reward
        result['begin'] = r.begin
        result['end'] = r.end

        rewards << result
      end
    end
    return rewards
  end

end
