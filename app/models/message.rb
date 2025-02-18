class Message < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'

  validates :content, presence: true
  validates :sender, presence: true
  validates :recipient, presence: true

  scope :between_users, ->(user1_id, user2_id) do
    where(sender_id: [user1_id, user2_id], recipient_id: [user1_id, user2_id])
  end
end