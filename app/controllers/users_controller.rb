class UsersController < ApplicationController

  before_filter :authorize

  def index
  end

  def friends
    friends = client.friends(current_user.uid)
    if friends[:total].to_i > 0
      @pages = (friends[:total].to_i / friends[:end].to_i) + 1
    end
    @friends = friends[:user]
  end

  def more_friends
    friends = client.friends(current_user.uid, {page: params[:page]})[:user]
    render json: friends
  end

end