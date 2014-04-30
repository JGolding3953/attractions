module ListsHelper
  
  def set_slider_content(slides)
    slides.order('average_rating ASC LIMIT 5')
  end
  
  def set_random(random_list)
    random_list.order('RANDOM()').limit(4)
  end
  
  def set_popular(popular_list)
    popular_list.order('average_rating ASC LIMIT 4')
  end
  
  def set_ca_limit(ca_limit_list)
    ca_limit_list.order('average_rating ASC LIMIT 1')
  end
  
end