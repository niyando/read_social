class FriendsController < ApplicationController

  before_filter :authorize

  def show
    @friend = client.user(params[:id])[:name]
    books = get_shelf(shelf_param)
    if books[:total].to_i > 0
      @pages = ((books[:total].to_i / books[:end].to_i) + 1) 
    end
    @books = books[:books]
  end

  def more_books
    books = get_shelf(shelf_param, params[:page])
    render json: books[:books]
  end

  private

  def shelf_param
    ['currently-reading','read','to_read'].include?(params[:shelf]) ? params[:shelf] : 'read'
  end

  def get_shelf(name, page=1)
    client.shelf(params[:id], name, {page: page, per_page: 30})
  rescue Goodreads::Forbidden => e
    []
  end
  
end