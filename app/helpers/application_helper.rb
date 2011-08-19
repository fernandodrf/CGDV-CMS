module ApplicationHelper
  
	# Return title on per-page basis.
  def title
  @base_title = "CGDV"
    if @title.nil?
      @base_title
    else
	  "#{@base_title} | #{@title}"    	
    end
  end

  def logo
    image_tag("logo.jpg", :alt => "CGDV",:size => "152x62", :class => "round")
  end
  
    def logoprint
    image_tag("logo.jpg", :alt => "CGDV",:size => "98x40", :class => "round")
  end
 
  def edad(birthdate)
    age = Date.today.year - birthdate.year
    age -= 1 if Date.today < birthdate + age.years #for days before birthdate
    return age
  end  

  def tiempo(inicio,fin)
  	horas = inicio.hour - fin.hour
  	min = inicio.minutes - fin.minutes
  	
  end
   
end
