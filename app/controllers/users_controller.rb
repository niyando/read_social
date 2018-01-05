class UsersController < ApplicationController

  before_filter :authorize

  def index
  end

  def friends
    user_id = client.user_id
    @friends = client.friends(user_id)
  end

end