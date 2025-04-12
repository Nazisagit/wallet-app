module Api
  class ApplicationController < ActionController::API
    include TokenAuthentication

    private

    def show_errors(exception)
      render json: { error: exception }, status: :bad_request
    end
  end
end
