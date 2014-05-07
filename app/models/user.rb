class User < ActiveRecord::Base
  include ActiveModel::Validations    # required because some before_validations are defined in devise
  extend  ActiveModel::Callbacks      # required to define callbacks
  extend  Devise::Models

  define_model_callbacks :validation  # required by Devise
  devise :remote_authenticatable

  # Available devise modules are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable,
  # :database_authenticatable, :registerable,
  # :recoverable, :rememberable, :trackable, :validatable
end
