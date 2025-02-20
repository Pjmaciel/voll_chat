module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

    def find_verified_user
      token = request.query_parameters['token']
      Rails.logger.info "WS Token recebido: #{token}" # Adicione este log

      if token
        decoded_token = JsonWebToken.decode(token)
        user = User.find(decoded_token[:user_id])
        return user if user
      end

      reject_unauthorized_connection
    rescue JWT::DecodeError, ActiveRecord::RecordNotFound => e
      Rails.logger.error "WS Auth Error: #{e.message}" # Adicione este log
      reject_unauthorized_connection
    end
  end
end