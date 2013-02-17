require 'spec_helper'

describe BritchBot do
  describe '.extract_actions' do
    let(:messages) { "/mfw" }

    before do
      @actions = Bot.extract_action(messages)
    end

    it 'has the mfw action' do
      @actions.should == "my_face"
    end
  end

  describe '.parse_messages' do
    before do
      @keywords_found = Bot.parse_messages
    end

    it 'finds keywords' do
      @keywords_found.should be_true
    end
  end
end
