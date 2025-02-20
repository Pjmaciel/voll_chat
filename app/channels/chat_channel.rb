# app/channels/chat_channel.rb
class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_for current_user
  end

  def unsubscribed
    stop_all_streams
  end

  def receive(data)
    message = Message.create!(
      content: data['content'],
      sender: current_user,
      recipient_id: data['recipient_id']
    )

    # Broadcast das mensagens para o WebSocket do destinatário
    ChatChannel.broadcast_to(
      message.recipient, # O destinatário recebe no canal
      {
        id: message.id,
        content: message.content,
        sender: { id: current_user.id, email: current_user.email },
        created_at: message.created_at
      }
    )
  end
end