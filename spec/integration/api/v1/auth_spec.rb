require 'swagger_helper'

RSpec.describe 'Authentication API', type: :request do
  path '/api/v1/auth/login' do
    post 'Authenticates user' do
      consumes 'application/json'
      produces 'application/json'
      parameter name: :auth, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: ['email', 'password']
      }

      response '200', 'user authenticated' do
        let(:auth) { { email: 'test@example.com', password: 'password123' } }
        run_test!
      end

      response '401', 'unauthorized' do
        let(:auth) { { email: 'wrong@email.com', password: 'wrong' } }
        run_test!
      end
    end
  end
end