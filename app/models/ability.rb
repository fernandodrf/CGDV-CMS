class Ability
  include CanCan::Ability

  def initialize(user)
    
  	user ||= User.new # guest user (not logged in)
    
    if user.admin?
      can :manage, :all
      
	else
		
	  if user.is_oficina?
        can [:read, :create, :edit, :update, :print, :notas], :all
        cannot [:destroy], [Note, Element, Patient]
        cannot :manage, [Volunteer, Timereport, Donor]
  	  end
      
	  if user.is_timereport?
	    can [:read, :create], [Timereport]
	    can [:read, :create], [VolTime]
	  end
	  
	  if user.is_ss?
	  	can [:trep], [Volunteer]
	    can [:read, :create], [ActivityReport]
	  end
	
    end
    
  end
end
