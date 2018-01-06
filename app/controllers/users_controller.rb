class UsersController < ApplicationController

  before_filter :authorize

  def index
  end

  def friends
    friends = client.friends(current_user.uid)
    @pages = (friends[:total].to_i / friends[:end].to_i) + 1
    @friends = friends[:user]
  end

  def more_friends
    friends = client.friends(current_user.uid, {page: params[:page]})[:user]
    render json: friends
  end

end