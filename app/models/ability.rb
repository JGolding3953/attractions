class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    
    can :create, User
    can :read, Attraction
    can :read, Category
    can :index, User

    if user.has_role? :admin
      can :manage, :all
    end
    
    if user.has_role? :user
      can [:read, :update], User do |account|
        account.email == user.email
      end
      cannot [:create, :index], User
    end
  end
end