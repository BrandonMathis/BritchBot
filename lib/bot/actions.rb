require 'net/http'

module Bot
  module Actions
    def self.jpgTo

    end

    # Return image message hash for groupme
    #
    # ie:
    # {:message=>
    #   {:text=>"url.to.image"}
    # }
    #
    # Will just error out at doc.at if jpg.to gives no image
    def self.jpg(key)
      uri = URI.parse("http://#{key}.jpg.to/+r")
      begin
        response = Net::HTTP.get_response(uri)
        doc = Hpricot(response.body)
        img = doc.at('img')['src']
      end while !(img =~ /(\.jpg|\.png|\.gif)$/)
      GroupMe.image_message(img)
    end
  end
end
