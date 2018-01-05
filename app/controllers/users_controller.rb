class UsersController < ApplicationController

  before_filter :authorize

  def index
  end

  def friends
    @friends = []
    friends = client.friends(current_user.uid)
    @friends += friends[:user]
    if friends[:total].to_i > friends[:end].to_i
      pages = (friends[:total].to_i / friends[:end].to_i)
      2.upto(pages+1) do |p|
        @friends += client.friends(current_user.uid, {page: p})[:user]
      end
    end
  end

end