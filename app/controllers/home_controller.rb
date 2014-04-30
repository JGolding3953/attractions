class HomeController < ApplicationController
  include ListsHelper
  def index
    @attractions = Attraction.all    
    @featured = set_slider_content(@attractions)
    @random_list = set_random(@attractions)
    @popular_list = set_popular(@attractions)
  end
end
