module Bot
  module Actions
    def self.jpgTo

    end

    # TODO Need to actually get some rand mfw images
    def self.mfw
      GroupMe.image_message("http://i.imgur.com/qSWNG8V.png")
    end

    def self.bacon
      GroupMe.image_message("http://i.imgur.com/LgMb5Gm.png")
    end
  end
end
