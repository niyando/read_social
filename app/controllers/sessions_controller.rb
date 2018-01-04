class SessionsController < ApplicationController

  before_filter :set_consumer, except: [:destroy]

  def auth
    request_token = @consumer.get_request_token
    session[:token] = request_token.token
    session[:token_secret] = request_token.secret
    redirect_to request_token.authorize_url
  end

  def create
    hash = { oauth_token: session[:token], oauth_token_secret: session[:token_secret]}
    request_token  = OAuth::RequestToken.from_hash(@consumer, hash)
    access_token = request_token.get_access_token
    # user = User.from_omniauth(access_token)
    # session[:user_id] = user.id
    redirect_to '/'
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

end