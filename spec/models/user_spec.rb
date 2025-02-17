require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validações" do
    it "é válido com um email e senha" do
      user = User.new(email: "test@example.com", password: "password123")
      expect(user).to be_valid
    end

    it "é inválido sem email" do
      user = User.new(password: "password123")
      expect(user).to_not be_valid
    end

    it "é inválido sem senha" do
      user = User.new(email: "test@example.com")
      expect(user).to_not be_valid
    end

    it "é inválido se o email já foi usado" do
      User.create!(email: "test@example.com", password: "password123")
      user = User.new(email: "test@example.com", password: "password456")
      expect(user).to_not be_valid
    end

    it "requer senha com pelo menos 6 caracteres" do
      user = User.new(email: "test@example.com", password: "12345")
      expect(user).to_not be_valid
    end
  end
end
