require 'net/http'

module Bot
  module Actions
    def self.jpgTo

    end

    # TODO Need to actually get some rand mfw images
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
