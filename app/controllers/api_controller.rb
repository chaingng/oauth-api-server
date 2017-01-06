class ApiController < ApplicationController
  before_action :doorkeeper_authorize!
  before_filter :set_parameters

  def index
    render json: { foo: 'bar'}
  end

  def user
    render json: current_user
  end

  def set_parameters
    sign_in 'user', User.find(doorkeeper_token.resource_owner_id)
  end
end
