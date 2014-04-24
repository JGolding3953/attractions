class ChangeAttractionRatingColumn < ActiveRecord::Migration
  def change
    add_column :attractions, :average_rating, :float
    remove_column :attractions, :rating
  end
end
