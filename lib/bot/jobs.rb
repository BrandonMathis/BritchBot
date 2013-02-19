module Bot
  class Jobs
    def poll_all_groups
      messages = GroupMe.get_messages(Bot.group).body
      messages = Bot.extract_new_messages(messages)
      Bot.parse_messages(messages)
    end

    def poll
      poll_all_groups
      self.delay(run_at: 3.seconds.from_now).poll
    end

    def self.start_me_up
      new.poll
    end
  end
end
