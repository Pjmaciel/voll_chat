class Message < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'

  validates :content, presence: true
  validates :sender, presence: true
  validates :recipient, presence: true

  after_create_commit do
    broadcast_message
  end

  scope :between_users, ->(user1_id, user2_id) do
    where(sender_id: [user1_id, user2_id], recipient_id: [user1_id, user2_id])
  end

  private

  def broadcast_message
    ActionCable.server.broadcast(
      "chat_#{recipient.id}",
      {
        sender: sender.email,
        content: content,
        timestamp: created_at.strftime("%H:%M")
      }
    )
  end
end