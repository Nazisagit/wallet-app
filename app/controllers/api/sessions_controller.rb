module Api
  class SessionsController < Api::ApplicationController
    allow_unauthenticated_access only: :create
    def create
      if user = User.authenticate_by(params.permit(:email_address, :password))
        render json: { token: user.auth_token }, status: :ok
      else
        render json: { error: "Invalid email or password" }, status: :unauthorized
      end
    end
  end
end
