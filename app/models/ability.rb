class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    
    can [:index, :create, :read], User
    can :read, Attraction
    can :read, Category
    can :read, Review
    cannot :index, Category
    cannot :index, User

    if user.has_role? :admin
      can :manage, :all
    end
    
    if user.has_role? :user
      can [:read, :update], User do |account|
        account.email == user.email
      end
      cannot [:index, :create], User
    end
  end
end