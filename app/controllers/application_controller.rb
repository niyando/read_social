class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    if session[:user_uid]
      @current_user ||= User.find_by_uid(session[:user_uid])
    end
  end
  helper_method :current_user

  def authorize
    redirect_to '/' and return unless current_user
    client
  end

  def client
    @goodreads_client ||= set_client
  end

  def consumer
    OAuth::Consumer.new(
      Goodreads.configuration[:api_key],
      Goodreads.configuration[:api_secret],
      site: "https://www.goodreads.com"
    )
  end

  private


  def set_client
    hash = { oauth_token: current_user.token, oauth_token_secret: current_user.token_secret}
    access_token = OAuth::AccessToken.from_hash(consumer, hash)
    Goodreads.new(oauth_token: access_token)
  end

end