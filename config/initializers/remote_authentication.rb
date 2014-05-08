require "net/http"
require "json"

module RemoteAuthentication
  extend ActiveSupport::Concern
  #
  # Here you do the request to the external webservice
  # If the authentication is successful it returns a resource instance
  # If the authentication fails it returns nil
  #
  def self.authenticate! auth_hash
    return false if auth_hash[:email].nil? || auth_hash[:password].nil? || auth_hash[:payroll_name].nil?
    
    case auth_hash[:payroll_name].to_sym
    when :simple_payroll_demo
      uri = URI('http://localhost:3001/api/v1/users/sign_in')
      res = Net::HTTP.post_form(uri, auth_hash.slice(:email, :password))
    end

    if res.code.to_i == Rack::Utils.status_code(:ok)
      return resource = User.where(email: auth_hash[:email]).first_or_create
    else
      nil
    end
  end
end