require 'rails_helper'

RSpec.describe ChatChannel, type: :channel do
  let(:user) { create(:user) }

  before do
    stub_connection current_user: user
  end

  it "subscribes to chat stream" do
    subscribe room: "general"
    expect(subscription).to be_confirmed
    expect(subscription).to have_stream_from("chat_general")
  end

  it "broadcasts received message" do
    subscribe room: "general"

    expect {
      perform :receive, { "message" => "Hello World" }
    }.to have_broadcasted_to("chat_general").with(
      hash_including(
        message: "Hello World",
        user_id: user.id
      )
    )
  end
end

