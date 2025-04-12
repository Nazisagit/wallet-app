module TokenAuthentication
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user!
  end

  class_methods do
    def allow_unauthenticated_access(**options)
      skip_before_action :authenticate_user!, **options
    end
  end

  def authenticate_user!
    token = request.headers["Authorization"].to_s.remove("Bearer ")
    @current_user = User.find_by(auth_token: token)
    render json: { error: "Unauthorized" }, status: :unauthorized unless @current_user
  end

  def current_user
    @current_user
  end
end
