class Ability
  include CanCan::Ability

  def initialize(user)
    
  	user ||= User.new # guest user (not logged in)
    
    if user.admin?
      can :manage, :all
    else
      can [:read, :create, :update, :print], :all
      cannot [:destroy], [Note, Element, Patient]
    end
  end
end
