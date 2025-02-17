require 'rails_helper'

RSpec.describe UserSerializer, type: :serializer do
  let(:user) { create(:user) } # Usando FactoryBot para criar um usuário válido
  let(:serialized_user) { described_class.new(user).serializable_hash }

  it "inclui id, email, created_at e updated_at" do
    expect(serialized_user.keys).to contain_exactly(:id, :email, :created_at, :updated_at)
  end

  it "não inclui password_digest" do
    expect(serialized_user).not_to have_key(:password_digest)
  end
end
