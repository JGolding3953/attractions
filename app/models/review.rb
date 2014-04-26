class Review < ActiveRecord::Base
  has_one :user
  has_one :attraction
  
 # validates :user_id, presence: true
  validates :rating, presence: true
  
  default_scope -> { order('created_at DESC') }
end
