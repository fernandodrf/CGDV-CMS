module NotesHelper

def cgdvcode(note)
  @cgdvcode = note.patient.id
end

def name(note)
  @name = note.patient.name
end

end
