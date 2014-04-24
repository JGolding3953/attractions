class Attraction < ActiveRecord::Base
	belongs_to :category 

	before_save :assign_default_category

  	# Default value for category id key, if blank.
  	def assign_default_category
  		self.category_id ||= 4
  	end
end
