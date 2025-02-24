require 'swagger_helper'

RSpec.describe 'Messages API', type: :request do
  path '/api/v1/messages' do
    get 'Lista mensagens' do
      tags 'Mensagens'
      security [bearer_auth: []]
      produces 'application/json'
      parameter name: :user_id, in: :query, type: :integer, required: false

      response '200', 'messages found' do
        let(:Authorization) { "Bearer #{JsonWebToken.encode(user_id: create(:user).id)}" }
        run_test!
      end

      response '401', 'unauthorized' do
        let(:Authorization) { 'Bearer invalid' }
        run_test!
      end
    end

    post 'Envia mensagem' do
      tags 'Mensagens'
      security [bearer_auth: []]
      consumes 'application/json'
      parameter name: :message, in: :body, schema: {
        type: :object,
        properties: {
          message: {
            type: :object,
            properties: {
              content: { type: :string },
              recipient_id: { type: :integer }
            },
            required: ['content', 'recipient_id']
          }
        }
      }

      response '201', 'message created' do
        let(:user) { create(:user) }
        let(:recipient) { create(:user) }
        let(:Authorization) { "Bearer #{JsonWebToken.encode(user_id: user.id)}" }
        let(:message) { { message: { content: 'Hello', recipient_id: recipient.id } } }
        run_test!
      end
    end
  end
end