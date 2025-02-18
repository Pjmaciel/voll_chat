class MessageSerializer < ActiveModel::Serializer
  attributes :id, :content, :read, :created_at, :sender, :recipient

  def sender
    {
      id: object.sender.id,
      email: object.sender.email
    }
  end

  def recipient
    {
      id: object.recipient.id,
      email: object.recipient.email
    }
  end
end