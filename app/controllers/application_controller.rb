# app/controllers/application_controller.rb
class ApplicationController < ActionController::API
  def authenticate_request
    header = request.headers['Authorization']
    begin
      if header
        token = header.split(' ').last
        @decoded = JsonWebToken.decode(token)
        @current_user = User.find(@decoded[:user_id])
      else
        raise "Token não fornecido"
      end
    rescue StandardError => e
      Rails.logger.error "Erro de autenticação: #{e.message}"
      Rails.logger.error "Headers recebidos: #{request.headers['Authorization']}"
      render json: { errors: e.message }, status: :unauthorized
    end
  end

  def current_user
    @current_user
  end
end