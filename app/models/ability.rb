class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.admin?
      can :manage, :all
      can :partner_request, Project
    else
      can :read, :all
      can :create, Project
      can :partner_request, Project
    end

    can [:update, :destroy], Project, author_id: user.id
  end
end