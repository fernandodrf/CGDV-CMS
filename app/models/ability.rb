class Ability
  include CanCan::Ability

  def initialize(user)
    
  	user ||= User.new # guest user (not logged in)
    
    if user.admin?
      can :manage, :all
      
	elsif user.is_oficina?
      can [:read, :create, :edit, :update, :print, :notas], :all
      cannot [:destroy], [Note, Element, Patient]
      cannot :manage, [Volunteer, Timereport, Donor]
      
	elsif user.is_timereport?
	  can [:read, :create], [Timereport]
	  can [:read], [Contact]
	  
	else
	  #Nothing
    end
    
  end
end
