# app/channels/application_cable/connection.rb
module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

    def find_verified_user
      token = params[:token] || request.headers[:HTTP_AUTHORIZATION]&.split(' ')&.last
      return reject_unauthorized_connection unless token

      decoded_token = JsonWebToken.decode(token)
      User.find(decoded_token[:user_id])
    rescue JWT::DecodeError, ActiveRecord::RecordNotFound
      reject_unauthorized_connection
    end
  end
end