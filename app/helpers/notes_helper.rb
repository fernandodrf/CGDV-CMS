module NotesHelper

	def cgdvcode(note)
	  @cgdvcode = note.patient.cgdvcode
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
end
