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

    can [:update, :destroy], Project, user_id: user.id
  end
end