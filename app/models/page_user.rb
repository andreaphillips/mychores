class PageUser < ActiveRecord::Base
  attr_accessible :device_token, :page_id, :read, :deleted, :user_id
  belongs_to :user, :foreign_key => :user_id
  belongs_to :device, :foreign_key => :device_token
  belongs_to :page

  def self.unread_messages(user)
    unread = self.find_all_by_device_token(user,:conditions => {:created_at => 1.week.ago..1.second.ago} )
    messages = []
    unread.each do |u|
      message = Hash.new
      message["id"] = u.page_id
      message["name"] = u.page.name
      message["content"] = u.page.content
      message["read"] = u.read
      messages << message
    end
    return messages
  end

end
