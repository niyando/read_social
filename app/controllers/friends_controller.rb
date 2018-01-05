class FriendsController < ApplicationController

  before_filter :authorize

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
  
end