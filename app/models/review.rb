class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :attraction
  
 # validates :user_id, presence: true
  validates :rating, presence: true
  validates_numericality_of :rating, :in => 1..5
  
  default_scope -> { order('created_at DESC') }
end
