class AddColumnsAttractions < ActiveRecord::Migration
  def change
     add_column :attractions, :name, :string
     add_column :attractions, :summary, :text, :limit => nil
     add_column :attractions, :description, :text, :limit => nil
     add_column :attractions, :category_id, :integer
     add_column :attractions, :area, :string
     add_column :attractions, :rating, :string
     add_column :attractions, :website, :string
     add_column :attractions, :imageurl, :string
  end
end