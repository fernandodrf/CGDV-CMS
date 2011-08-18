module VolunteersHelper
  def vol_status(status)
    @text_status = Volunteer::STATUS[status-1][0]
  end
end
