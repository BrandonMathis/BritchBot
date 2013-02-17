module Bot
  class << self
    def parse_messages
      response_json = JSON.parse(GroupMe.get_messages("3647885").body)
      messages = extract_messages(response_json)
      messages.each{ |message| keywords = message.extract_keywords }
      return true if keywords
      false
    end

    def keyword_actions
      [
        {key: /\/mfw/, action: "my_face"}
      ]
    end

    def extract_action(message)
      keyword_actions.each do |keyword_action|
        return keyword_action[:action] if message =~ keyword_action[:key]
      end
      return []
    end

    def extract_messages(message_hash)
      message_hash["response"]["messages"].map{ |message| message["text"] }
    end
  end
end
