module Bot
  class << self
    def group; "3647885" end

    def keyword_actions
      [
        {key: /\/mfw/, action: "my_face"}
      ]
    end

    def parse_messages
      response_json = JSON.parse(GroupMe.get_messages(group).body)
      actions = extract_messages(response_json)
      messages.each do |message|
        action = extract_action message
        reply = Bot::Actions.send(action)
        GroupMe.send_message(group, reply)
      end
      return true if actions
      false
    end

    def extract_action(message)
      keyword_actions.each do |keyword_action|
        return keyword_action[:action] if message =~ keyword_action[:key]
      end
      return false
    end

    def extract_messages(message_hash)
      message_hash["response"]["messages"].map{ |message| message["text"] }
    end
  end
end
