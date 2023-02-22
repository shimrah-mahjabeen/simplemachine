module RequestHelpers
  def auth_headers
    @auth_headers ||= user.create_new_auth_token
  end

  def admin_auth_headers
    @admin_auth_headers ||= admin.create_new_auth_token
  end

  def customer_auth_headers
    @customer_auth_headers ||= customer.create_new_auth_token
  end

  def json
    raise 'Response is nil. Are you sure you made a request?' unless response

    JSON.parse(response.body, symbolize_names: true)
  end

  def body
    json[:body]
  end
end
