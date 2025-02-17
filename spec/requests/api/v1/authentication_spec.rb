require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  describe 'POST /api/v1/auth/login' do
    let(:user) { create(:user, email: 'test@example.com', password: 'password123') }

    context 'when credentials are valid' do
      before do
        post '/api/v1/auth/login', params: {
          email: user.email,
          password: 'password123'
        }
      end

      it 'returns a token' do
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to include('token')
      end
    end

    context 'when credentials are invalid' do
      before do
        post '/api/v1/auth/login', params: {
          email: user.email,
          password: 'wrong_password'
        }
      end

      it 'returns unauthorized status' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end