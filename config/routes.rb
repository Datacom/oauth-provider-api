OauthProviderApi::Application.routes.draw do
  devise_for :users
  use_doorkeeper
end
