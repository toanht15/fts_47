class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    if user.admin?
      can :manage, :all
    else
      can :read, :all
      can [:create, :read], Exam
      can [:create, :update, :destroy], Question
    end
  end
end
