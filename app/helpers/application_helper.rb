module ApplicationHelper
  
	# Return title on per-page basis.
  def title
  @base_title = "CGDV"
    if @title.nil?
      base_title
    else
	  "{base_title} | #{@title}"    	
    end
  end

  def logo
    image_tag("logo.jpg", :alt => "CGDV",:size => "152x62", :class => "round")
  end
  
end
