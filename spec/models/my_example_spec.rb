require 'timeout'

describe "apple push notifications" do

  before do
    @server = Grocer.server(port: 2195)
    @server.accept # starts listening in background
  end

  after do
    @server.close
  end

  specify "As a user, I receive notifications on my phone when awesome things happen" do
    # ... exercise code that would send APNS notifications ...
    #User.create(:cloud_id => '7511a981b1a5b0f9967cf73a9d9116baaab2f89f6b73aa5b6a036dfb55a96f76', :email => "andrea@eiscuer.com")
    #Notification.create(:title => "An awesome thing happened", :recipients => '{"all":"1","ages":"","country":"","language":"","chore":"","devices":""}')

    pusher = Grocer.pusher(
        certificate: File.join(Rails.root,"db/certificates/mychorescert.pem"),
        port:        2195,                     # optional
        retries:     3                         # optional
    )
    puts 'MAURREEEN!'

    notification = Grocer::Notification.new(
        device_token: '7511a981b1a5b0f9967cf73a9d9116baaab2f89f6b73aa5b6a036dfb55a96f76',
        alert:"An awesome thing happened",
        badge:42,
        identifier:1234 # optional
    )
    puts notification

    pusher.push(notification)

    puts 'MAURREEEN IS NOTIFIED!'

    Timeout.timeout(3) {
      notification = @server.notifications.pop # blocking
      expect(notification.alert).to eq("An awesome thing happened")
    }

  end
end