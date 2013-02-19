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

  describe '.extract_action' do
    before do
      @action = Bot.extract_action(message)
    end

    context 'mfw' do
      let(:message) { "/mfw" }

      it 'has the mfw action' do
        @action.should == "my_face"
      end
    end

    context 'when given the wildcard jpg' do
      let(:message) { "/something" }

      it "has the jpg action with the something param" do
        @action.should == {method: "jpg", param: "something"}
      end
    end
  end
end
