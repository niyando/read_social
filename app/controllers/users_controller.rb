class UsersController < ApplicationController

  before_filter :authorize
  before_filter :set_consumer

  def index
  end

  def friends
    user_id = client.user_id
    @friends = client.friends(user_id)
  end

  private

  def client
    @goodreads_client ||= set_client
  end

  def set_client
    hash = { oauth_token: session[:token], oauth_token_secret: session[:token_secret]}
    access_token = OAuth::AccessToken.from_hash(@consumer, hash)
    Goodreads.new(oauth_token: access_token)
  end

end