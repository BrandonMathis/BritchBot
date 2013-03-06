module Bot
  class << self
    # Just a temporary thing for now. The Bot should respond
    # in all groups it is a member of once it has its own account
    def group; "3647885" end

    # Define all regex keys and association actions here
    #
    # Actions can be found at lib/bot/actions
    def keyword_actions
      [
        {key: /^\/(\w+)/, action: "jpg"}
      ]
    end

    # Returns: a list of group ids Bot is a member of
    def get_group_ids
    end

    # Parse over array of message and send proper response
    # to GroupMe
    def parse_messages(messages)
      messages.each do |message|
        action = extract_action message if message =~ /^\//
        if action
          reply = Bot::Actions.send(action[:method], action[:param])
          GroupMe.send_message(group, reply)
        end
      end
    end

    # Returns: a list of text messages
    def extract_new_messages(messages)
      message_hash = JSON.parse(messages)
      message_hash["response"]["messages"].map do |message|
        next if Message.where(groupme_id: message["id"]).present?
        Message.create(groupme_id: message["id"], text: message["text"])
        message["text"]
      end.compact
    end

    # Come back with a hash of action methods and params
    #
    # ie:
    # {method: 'jpg', param: 'baconpancake'}
    def extract_action(message)
      keyword_actions.each do |keyword_action|
        # match for key and capture the params if there is a capture
        # inside of the regex
        if params = message.scan(keyword_action[:key]).flatten.first
          return {method: keyword_action[:action], param: params}
        end
      end
      return false
    end
  end
end
