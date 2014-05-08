# require 'net/http'

module Api::V1
  class TimesheetsController < ApiController
    doorkeeper_for :all

    def index
      binding.pry
      uri = URI('http://localhost:3001/api/v1/timesheets')
      params = { email: current_resource_owner.email }
      uri.query = URI.encode_www_form(params)
      
      res = Net::HTTP.get_response(uri)
      if res.code.to_i == Rack::Utils.status_code(:ok)
        render json: res.body
      else
        render json: { errors: "Unauthorized access"}, status: res.code
      end
    end

    def show
      uri = URI('http://localhost:3001/api/v1/timesheets')
      params = { id: params[:timesheet_id] }
      uri.query = URI.encode_www_form(params)
      
      res = Net::HTTP.get_response(uri)
      if res.code.to_i == Rack::Utils.status_code(:ok)
        render json: res.body
      else
        render json: { errors: "Unauthorized access"}, status: res.code
      end
    end

    def me
      render json: current_resource_owner, status: 200
    end

  end
end