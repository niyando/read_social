class FriendsController < ApplicationController

  before_filter :set_consumer

  def show
    @cr_books = get_shelf('currently-reading')
    @r_books = get_shelf('read')
    @tr_books = get_shelf('to_read')
  end

  private

  def get_shelf(name)
    client.shelf(params[:id], name)[:books]
  rescue Goodreads::Forbidden => e
    []
  end

  def client
    @goodreads_client ||= set_client
  end

  def set_client
    hash = { oauth_token: session[:token], oauth_token_secret: session[:token_secret]}
    access_token = OAuth::AccessToken.from_hash(@consumer, hash)
    Goodreads.new(oauth_token: access_token)
  end
  
end