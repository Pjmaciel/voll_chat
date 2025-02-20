# lib/json_web_token.rb
module JsonWebToken
  SECRET_KEY = Rails.application.credentials.secret_key_base || Rails.application.secrets.secret_key_base

  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    begin
      decoded = JWT.decode(token, SECRET_KEY)[0]
      HashWithIndifferentAccess.new decoded
    rescue JWT::ExpiredSignature
      raise "Token expirado"
    rescue JWT::DecodeError
      raise "Token inválido"
    rescue StandardError => e
      Rails.logger.error "Erro ao decodificar token: #{e.message}"
      raise e
    end
  end
end