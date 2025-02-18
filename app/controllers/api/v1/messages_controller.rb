module Api
  module V1
    class MessagesController < ApplicationController
      before_action :authenticate_request

      def create
        message = current_user.sent_messages.build(message_params)

        if message.save
          render json: message, serializer: MessageSerializer, status: :created
        else
          render json: { errors: message.errors.full_messages },
                 status: :unprocessable_entity
        end
      end

      def index
        if params[:user_id]
          messages = Message.between_users(current_user.id, params[:user_id])
                            .order(created_at: :desc)
        else
          messages = current_user.received_messages
                                 .or(current_user.sent_messages)
                                 .order(created_at: :desc)
        end

        render json: messages, each_serializer: MessageSerializer
      end

      private

      def message_params
        params.require(:message).permit(:content, :recipient_id)
      end
    end
  end
end