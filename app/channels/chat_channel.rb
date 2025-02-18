class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_#{params[:room]}"
  end

  def unsubscribed
    stop_all_streams
  end

  def receive(data)
    ActionCable.server.broadcast(
      "chat_#{params[:room]}",
      {
        message: data['message'],
        user_id: current_user.id,
        created_at: Time.current
      }
    )
  end
end