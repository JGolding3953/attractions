class Review < ActiveRecord::Base
  belongs_to :user,  foreign_key: "user_id"
  belongs_to :attraction,  foreign_key: "attraction_id"
  
  validates :user_id, presence: true
  validates :rating, presence: true
  
  default_scope -> { order('created_at DESC') }
end
