require 'swagger_helper'

RSpec.describe 'Users API' , type: :request do
  path '/api/v1/users' do
    post 'Cria usuário' do
      tags 'Usuários'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              email: { type: :string },
              password: { type: :string },
              password_confirmation: { type: :string }
            },
            required: %w[email password password_confirmation]
          }
        }
      }

      response '201', 'user created' do
        let(:user) { { user: { email: 'test@example.com', password: 'password123', password_confirmation: 'password123' } } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:user) { { user: { email: 'test@example.com' } } }
        run_test!
      end
    end
  end
end