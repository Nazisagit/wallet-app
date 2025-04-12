module Api
  class ApplicationController < ActionController::API
    include TokenAuthentication
  end
end
