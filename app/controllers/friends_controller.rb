class FriendsController < ApplicationController

  before_filter :authorize

  def show
    @friend = client.user(params[:id])[:name]
    @books = get_shelf(shelf_param)
  end

  private

  def shelf_param
    ['currently-reading','read','to_read'].include?(params[:shelf]) ? params[:shelf] : 'read'
  end

  def get_shelf(name)
    client.shelf(params[:id], name)[:books]
  rescue Goodreads::Forbidden => e
    []
  end
  
end