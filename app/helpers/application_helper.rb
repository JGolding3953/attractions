module ApplicationHelper
  
  def flash_class(level)
    case level
      when :notice then "alert alert-info"
      when :success then "alert alert-success"
      when :error then "alert alert-error"
      when :alert then "alert alert-alert"
    end
  end
        
  def user_review_check(user_id, attr_id)
    @user_has_reviewed = false
    Review.where(attraction_id: attr_id).find_each do |review|
      if review.user_id == user_id
        @user_has_reviewed = true
        @user_review = review
      end
    end
  end
        
end
