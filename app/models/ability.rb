class Ability
	ROLES = [['Oficina',1],['Donadores',4],['Contactos',5],['Servicio Social',6]] 

  include CanCan::Ability

  def initialize(user)
    
  	user ||= User.new # guest user (not logged in)
    
    if user.admin?
      can :manage, :all
      
	else
		
	  if user.is_oficina?
        can [:read, :create, :edit, :update, :print, :notas], :all
        cannot [:destroy], [Note, Element, Patient]
        cannot :manage, [Volunteer, VolTime, Timereport, Donor]
  	  end
      
	  if user.is_timereport?
	    can [:read, :create], [Timereport]
	    can [:read, :create], [VolTime]
	  end
	  
	  if user.is_managetimereport?
	    can :manage, [Timereport]
	    can :manage, [VolTime]
	    cannot [:destroy], [Timereport, VolTime]
	  end	  
	  
	  if user.is_managedonor?
	  	can :manage, [Donor]
	  	cannot [:destroy], [Donor]
  	end
  	
		if user.is_managecontact?
	  	can :manage, [Contact]
	  	cannot [:destroy], [Contact]
  	end  	
	  
	  if user.is_ss?
	  	can [:trep], [Volunteer]
	    can [:read, :create], [ActivityReport]
	  end
	
    end
    
  end
end
