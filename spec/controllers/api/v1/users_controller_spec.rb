require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :request do
  describe "POST /api/v1/users" do
    let(:valid_attributes) { { user: { email: "test@example.com", password: "password123", password_confirmation: "password123" } } }
    let(:invalid_attributes) { { user: { email: "", password: "123" } } }

    it "cria um usuário com atributos válidos" do
      post "/api/v1/users", params: valid_attributes

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)).to include("message" => "Usuário criado com sucesso!")
    end

    it "retorna erro se os atributos forem inválidos" do
      post "/api/v1/users", params: invalid_attributes

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)).to include("errors")
    end
  end
end
