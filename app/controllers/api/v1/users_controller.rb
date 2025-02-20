module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_request

      def index
        @users = User.where.not(id: current_user.id)
        render json: @users, each_serializer: UserSerializer
      end

      def show
        @user = User.find(params[:id])
        render json: @user, serializer: UserSerializer
      end

      def create
        user = User.new(user_params)

        if user.save
          render json: { message: "Usuário criado com sucesso!", user: UserSerializer.new(user) }, status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
      end
    end
  end
end