module PatientsHelper

  def text_status(status)
    @text_status = Patient::STATUS[status-1][0]
  end

  def edad(birthdate)
    age = Date.today.year - birthdate.year
    age -= 1 if Date.today < birthdate + age.years #for days before birthdate
    return age
  end

end
