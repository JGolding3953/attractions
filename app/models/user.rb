class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, #:confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  
  validates :email, :uniqueness => true

  after_create :assign_default_role

  # Default value for role_id key, if blank (User).
  def assign_default_role
    if self.roles.blank?
      add_role(:user)
    end
  end
end
