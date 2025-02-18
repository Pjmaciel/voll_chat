class ApplicationController < ActionController::API
  def authenticate_request
    header = request.headers['Authorization']
    if header
      token = header.split(' ').last
      begin
        @decoded = JsonWebToken.decode(token)
        @current_user = User.find(@decoded['user_id'])
      rescue ActiveRecord::RecordNotFound => e
        render json: { errors: e.message }, status: :unauthorized
      rescue JWT::DecodeError => e
        render json: { errors: e.message }, status: :unauthorized
      rescue => e
        render json: { errors: e.message }, status: :unauthorized
      end
    else
      render json: { errors: 'Token not supplied' }, status: :unauthorized
    end
  end

  def current_user
    @current_user
  end
end