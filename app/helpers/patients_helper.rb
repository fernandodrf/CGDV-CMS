module PatientsHelper

  def text_status(status)
    @text_status = Patient::STATUS[status-1][0]
  end

end
