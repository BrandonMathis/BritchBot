module Bot
  module Actions
    # TODO Need to actually get some rand mfw images
    def self.mfw
      GroupMe.image_message("http://i.imgur.com/qSWNG8V.png")
    end
  end
end
