require 'spec_helper'

describe BritchBot do
  describe '.extract_messages' do
    let(:messages_json) { {
      "response" => {
        "messages" => [
          {
            "id" => "1234",
            "text" => "Hello"
          },
          {
            "id" => "5678",
            "text" => "Goodbye"
          }
        ]
      }
    }}

    before do
      @response = Bot.extract_messages(messages_json)
    end

    it 'comes back with the array of messages' do
      @response.should == ["Hello", "Goodbye"]
    end
  end

  describe '.extract_actions' do
    let(:messages) { "/mfw" }

    before do
      @actions = Bot.extract_action(messages)
    end

    it 'has the mfw action' do
      @actions.should == "my_face"
    end
  end
end
