# frozen_string_literal: true

module Api
  module V1
    class AuthenticationController < ApplicationController
      def login
        @user = User.find_by(email: params[:email])
        if @user&.authenticate(params[:password])
          token = JsonWebToken.encode(user_id: @user.id)
          render json: {
            token: token,
            user: UserSerializer.new(@user)
          }, status: :ok
        else
          render json: { error: 'Invalid credentials' }, status: :unauthorized
        end
      end
    end
  end
end