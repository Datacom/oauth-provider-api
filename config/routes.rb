OauthProviderApi::Application.routes.draw do
  use_doorkeeper

  get 'api/v1/me', to: 'api/v1/credentials#me', as: 'user_credentials'
  get 'api/v1/timesheets', to: 'api/v1/timesheets#index', as: 'timesheets'
end
