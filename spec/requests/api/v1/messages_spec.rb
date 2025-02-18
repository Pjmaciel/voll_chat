require 'rails_helper'

RSpec.describe "Messages API", type: :request do
  let(:sender) { create(:user) }
  let(:recipient) { create(:user, email: 'recipient@example.com') }
  let(:token) { JsonWebToken.encode(user_id: sender.id) }

  describe "POST /api/v1/messages" do
    let(:valid_attributes) do
      {
        message: {
          content: "Hello!",
          recipient_id: recipient.id
        }
      }
    end

    context "when authenticated" do
      before do
        post "/api/v1/messages",
             params: valid_attributes,
             headers: { 'Authorization' => token }
      end

      it "create new message" do
        expect(response).to have_http_status(:created)
        json = JSON.parse(response.body)
        expect(json['content']).to eq("Hello!")
      end
    end

    context "when not  authenticated" do
      before { post "/api/v1/messages", params: valid_attributes }

      it "return error not authenticated" do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "GET /api/v1/messages" do
    before do
      create(:message, sender: sender, recipient: recipient, content: "Hello!")
      get "/api/v1/messages", headers: { 'Authorization' => token }
    end

    it "return message list" do
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json).to be_an(Array)
      expect(json).not_to be_empty
      expect(json.first).to include('content', 'sender', 'recipient')
    end
  end
end