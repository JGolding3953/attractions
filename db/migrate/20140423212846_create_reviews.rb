class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :attraction_id
      t.integer :user_id
      t.text :comments,  :limit => nil
      t.integer :rating

      t.timestamps
    end
  end
end
