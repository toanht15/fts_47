class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    if user.admin?
      can :manage, :all
    else
      can [:create, :update], User
      can :read, :all
      can [:create, :update, :read], Exam
      can [:create, :update, :destroy], Question
      can :read, Category
    end
  end
end
