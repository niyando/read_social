class HomeController < ApplicationController


  def index
    redirect_to '/friends' if current_user.present?
  end
  
end