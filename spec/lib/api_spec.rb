require 'spec_helper'

describe GroupMe do
  describe '.send_message' do
    let(:message) { Bot::Actions.jpg("bacon") }

    before do
      @response = GroupMe.send_message(GROUP_ID, message)
    end

    it 'responds successfully' do
      @response.code.should == "201"
    end
  end

  describe '.get_messages' do
    before do
      @response = JSON.parse(GroupMe.get_messages(GROUP_ID).body)
    end

    it 'will get a json package' do
      @response["response"]["messages"].should_not be_blank
    end
  end
end
