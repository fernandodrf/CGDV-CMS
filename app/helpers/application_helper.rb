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

  def text_info(id)
    @text_status = Addinfo::ADDINFO[id-1][0]
  end

  def day_text(id)
  	@day = Dailyschedule::DAYS[id-1][0]
  end

  def text_diag(id)
  	diag = CatalogoDiagnostico.find(id).diagnostico
  end
  
  def text_pais(id)
  	if id == 0
  	  pais = ""
  	else
  	  pais = CatalogoCountry.find(id).country
  	end
  	return pais
  end
  
  def cgdvcode(note)
    @cgdvcode = note.patient.cgdvcode
  end

  def cgdvcode_vol(timereport)
  	@cgdvcode = timereport.volunteer.cgdvcode
  end
  
  def name_vol(timereport)
    @name = timereport.volunteer.name
  end
	
  def name(note)
    @name = note.patient.name
  end

  def subtotal(e)
    if !e.cuota.nil? && !e.cantidad.nil?
	  @subtotal = e.cuota * e.cantidad
    else
      @subtotal = 0
  	end
  end  
   
  def pat_status(status)
    @text_status = Patient::STATUS[status-1][0]
  end

  def remanente(socioeco)
    @remanente = socioeco.ingresos - socioeco.gastos
  end

  def gravatar_for(user, options = { :size => 50 })
    gravatar_image_tag(user.email.downcase, :alt => user.name,
                                            :class => 'gravatar',
                                            :gravatar => options)
  end

  def vol_status(status)
    @text_status = Volunteer::STATUS[status-1][0]
  end

  def donor_persona(per)
    @persona = Donor::Persona[per-1][0]
  end
  
  def tiempo_total(timereports)
    hrs = 0
    mins = 0
  	for tr in timereports do
  	  hrs += tr.tiempo_num[0]
  	  mins += tr.tiempo_num[1] 
  	  if mins >= 0.6
  	    hrs += 1
  	    mins -= 0.6
  	  end
    end
  	if mins >= 0.6
  	  hrs += 1
  	  mins -= 0.6
  	end
    hrs = number_with_precision(hrs, :precision => 0)
    mins = number_with_precision(mins*100, :precision => 0)
    return "#{hrs} hrs, #{mins} mins"
    #return tt%1
  end

end
