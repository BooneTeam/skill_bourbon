module DashboardHelper


  def timeline
    @sym_dates = {}
    new_dates = DateTime.now.beginning_of_day.step(DateTime.now.beginning_of_day + 10.days).select{|d| d}
    new_dates.each{|date| @sym_dates[date.to_date.to_s.to_sym] = [] }
    current_user.confirmed_upcoming_events.each do |event|
     @sym_dates.keys.each do |date|
       if event.date_scheduled.to_date.to_s == date.to_s
         @sym_dates[date] << event
       end
     end
   end
   @sym_dates
  end

end
