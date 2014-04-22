class Category < ActiveRecord::Base
	has_many :attractions, -> { order "rating DESC" }, :dependent => :destroy
	#Category.all :joins => :attractions
end
