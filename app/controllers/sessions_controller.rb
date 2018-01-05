class SessionsController < ApplicationController

  def auth
    request_token = consumer.get_request_token
    session[:token] = request_token.token
    session[:token_secret] = request_token.secret
    redirect_to request_token.authorize_url
  end

  def create
    hash = { oauth_token: session[:token], oauth_token_secret: session[:token_secret]}
    request_token  = OAuth::RequestToken.from_hash(consumer, hash)
    access_token = request_token.get_access_token
    gc = Goodreads.new(oauth_token: access_token)
    user = User.from_omniauth({uid: gc.user_id, token: access_token.token, token_secret: access_token.secret})
    session[:user_uid] = user.uid
    redirect_to '/friends'
  end

  def destroy
    session[:user_uid] = nil
    redirect_to root_url
  end

end