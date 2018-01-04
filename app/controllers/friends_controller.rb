class FriendsController < ApplicationController

  before_filter :set_consumer

  def show
    @books = client.shelf(params[:id], 'read')[:books]
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