module ApiHelper
  def login
    get api_sessions_path, params: { email_address: user.email_address, password: user.password }
  end

  def headers
    {
      "Authorization": "Bearer #{user.auth_token}"
    }
  end

  def json
    JSON.parse(response.body)
  end
end
