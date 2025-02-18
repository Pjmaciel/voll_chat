require 'rails_helper'

RSpec.describe Message, type: :model do
  describe "Validation" do
    let(:sender) { create(:user) }
    let(:recipient) { create(:user, email: 'recipient@example.com') }

    it "is valid with content, sender and recipient" do
      message = Message.new(
        content: "Hello!",
        sender: sender,
        recipient: recipient
      )
      expect(message).to be_valid
    end

    it "It is invalid without content" do
      message = Message.new(sender: sender, recipient: recipient)
      expect(message).to_not be_valid
    end

    it "It is invalid without sender" do
      message = Message.new(content: "Hello!", recipient: recipient)
      expect(message).to_not be_valid
    end

    it "It is invalid without recipient" do
      message = Message.new(content: "Hello!", sender: sender)
      expect(message).to_not be_valid
    end
  end
end
