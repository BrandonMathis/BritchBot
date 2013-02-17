require 'spec_helper'

describe GroupMe do
  describe '.get_messages' do
    before do
      @response = JSON.parse(GroupMe.get_messages(GROUP_ID).body)
    end

    it 'will get a json package' do
      @response["response"]["messages"].should_not be_blank
    end
  end
end
