class HomeController < ApplicationController
  def index
  	@attractions = Attraction.all
  end
end
