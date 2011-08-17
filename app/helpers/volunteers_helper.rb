module VolunteersHelper
  def text_status(status)
    @text_status = Volunteer::STATUS[status-1][0]
  end
end
