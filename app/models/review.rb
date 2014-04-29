class Review < ActiveRecord::Base
  has_one :user
  has_one :attraction
  
 # validates :user_id, presence: true
  validates :rating, presence: true
  validates_numericality_of :rating, :in => 1..5
  
  default_scope -> { order('created_at DESC') }
end
