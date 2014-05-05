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
  
  def set_ca_limit(cat_id, att_id)
    @category_attractions_limit = Attraction.where(category_id: cat_id)
    .where.not(id: att_id).order('average_rating ASC').limit(2)
  end
  
end