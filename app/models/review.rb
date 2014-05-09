class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :attraction
  
  validates :user_id, presence: true
  validates :attraction_id, presence: true
  validates :rating, presence: true
  validates :rating, numericality: { only_integer: true }
  validates :rating, :numericality => { :greater_than_or_equal_to => 1, :less_than_or_equal_to => 10 }
  
  validates_uniqueness_of :user_id, scope: [:attraction_id], message: "has already reviewed this attraction." 
  
  default_scope -> { order('created_at DESC') }
end
