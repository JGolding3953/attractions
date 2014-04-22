class HomeController < ApplicationController
  def index
  	@attractions = Attraction.all
	  @users = User.all
    @categories = Category.all
  end
end
