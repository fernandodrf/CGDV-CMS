module DailyschedulesHelper
  def day_text(id)
  	@day = Dailyschedule::DAYS[id-1][0]
  end
end
