module Api::V1
  class CredentialsController < ApiController
    doorkeeper_for :all

    def me
      render json: { id: current_resource_owner.id, email: current_resource_owner.email }
    end

  end
end