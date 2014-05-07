# Taken from http://4trabes.com/2012/10/31/remote-authentication-with-devise/
require "net/http"
require "json"

module Devise
  module Models
    module RemoteAuthenticatable
      extend ActiveSupport::Concern
      #
      # Here you do the request to the external webservice
      #
      # If the authentication is successful you should return
      # a resource instance
      #
      # If the authentication fails you should return false
      #
      def remote_authentication(auth_hash)
        case auth_hash[:payroll_name].to_sym
        when :simple_payroll_demo
          uri = URI('http://localhost:3001/api/v1/users/sign_in')
          res = Net::HTTP.post_form(uri, auth_hash.slice(:email, :password))
        end
        res.code.to_i == Rack::Utils.status_code(:ok) ? true : false
      end

      module ClassMethods
        ####################################
        # Overriden methods from Devise::Models::Authenticatable
        ####################################

        #
        # This method is called from:
        # Warden::SessionSerializer in devise
        #
        # It takes as many params as elements had the array
        # returned in serialize_into_session
        #
        # Recreates a resource from session data
        #
        # def serialize_from_session(id)
        #   resource = self.new
        #   resource.id = id
        #   resource
        # end

        #
        # Here you have to return an array with the data of your resource
        # that you want to serialize into the session
        #
        # You might want to include some authentication data
        #
        # def serialize_into_session(record)
        #   [record.id]
        # end

        # devise default
        # TODO: solve the issue with sessions
        def serialize_from_session(key=nil, salt=nil)
          record = to_adapter.get(key)
          record if record && record.authenticatable_salt == salt
        end

      end
    end
  end
end