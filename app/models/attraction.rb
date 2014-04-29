class Attraction < ActiveRecord::Base
  belongs_to :category # foreign key - category_id
  has_many :reviews

	before_save :assign_default_category
  
  	# Default value for category id key, if blank.
  	def assign_default_category
      c = Category.last
      self.category_id ||= c.category_id
  	end
    
    def set_average_rating
      if self.reviews.any?
        update_attribute(:average_rating, self.reviews.average(:rating).round(1))
      end
    end
end
