class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.admin?
      can :manage, :all
    else
      can :read, :all
      can :create, Project
    end
  
    can [:update, :destroy], Project, author_id: user.id
    can [:update, :destroy], Feedback, author_id: user.id
    can :update, User, id: user.id
  end
end