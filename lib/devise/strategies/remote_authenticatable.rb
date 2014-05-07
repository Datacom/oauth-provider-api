# Taken from http://4trabes.com/2012/10/31/remote-authentication-with-devise/
module Devise
  module Strategies
    class RemoteAuthenticatable < Authenticatable
      # valid? acts as a guard for the Strategy.
      # It should return true or false depending on if the strategy is valid for the request.
      # If it returns true, the Strategy will be run otherwise it is skipped.
      def valid?
        params['email'] && params['password'] && params['payroll_name']
        # e.g. true if certain request headers are available.
        # true
      end

      #
      # For an example check : https://github.com/plataformatec/devise/blob/master/lib/devise/strategies/database_authenticatable.rb
      #
      # Method called by warden to authenticate a resource.
      #
      def authenticate!
        auth_params = { email:        params[:email],
                        password:     params[:password],
                        payroll_name: params[:payroll_name] }
        #
        # mapping.to is a wrapper over the resource model
        #
        resource = mapping.to.new
        resource.email = params[:email]

        return fail! unless resource

        # remote_authentication method is defined in Devise::Models::RemoteAuthenticatable
        #
        # validate is a method defined in Devise::Strategies::Authenticatable. It takes
        # a block which must return a boolean value.
        #
        # If the block returns true the resource will be loged in
        # If the block returns false the authentication will fail!
        #
        if validate(resource){ resource.remote_authentication(auth_params) }
          resource = User.where(email: params[:email]).first_or_create
          success!(resource)
        else
          fail!("User authentication fails.")
        end
      end
    end
  end
end