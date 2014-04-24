class Category < ActiveRecord::Base
	has_many :attractions, :dependent => :destroy
	Category.all :joins => :attractions

	before_save :assign_default_category_id

  	# Default value for category_id key, if blank.
  	def assign_default_category_id
  		self.category_id = self.id
  	end
end
