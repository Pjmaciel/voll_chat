require 'rails_helper'

RSpec.describe ApplicationCable::Connection, type: :channel do
  let(:user) { create(:user) }
  let(:token) { JsonWebToken.encode(user_id: user.id) }

  it "successfully connects with valid token" do
    connect "/cable", headers: { "HTTP_AUTHORIZATION" => "Bearer #{token}" }
    expect(connection.current_user).to eq(user)
  end

  it "rejects connection without token" do
    expect { connect "/cable" }.to have_rejected_connection
  end

  it "rejects connection with invalid token" do
    allow(JsonWebToken).to receive(:decode).and_raise(JWT::DecodeError)
    expect {
      connect "/cable", headers: { "HTTP_AUTHORIZATION" => "Bearer invalid" }
    }.to have_rejected_connection
  end
end