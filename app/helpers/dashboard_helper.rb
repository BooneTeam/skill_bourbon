module DashboardHelper


  def timeline
    @sym_dates = {}
    new_dates = DateTime.now.beginning_of_day.step(DateTime.now.beginning_of_day + 17.days).select{|d| d}
    new_dates.each{|date| @sym_dates[date.to_date.to_s.to_sym] = [] }
    current_user.confirmed_upcoming_events.each do |event|
     @sym_dates.keys.each do |date|
       if event.meeting_date_scheduled.to_date.to_s == date.to_s
         @sym_dates[date] << event
       end
     end
   end
   @sym_dates
  end


  def current_user_dash_items
    @learning_skills       = current_user.apprenticeships.where(accepted_status: "confirmed")
    @pending_learnings     = current_user.apprenticeships.where(accepted_status: "pending")
    @earning_skills        = current_user.created_skills
    @apprentice_requests   = current_user.apprentice_requests
    @upcoming_events       = current_user.confirmed_upcoming_events
    @current_user_requests = current_user.skill_requests + @pending_learnings
    #make this better
    @open_requests         = @earning_skills.map(&:categories).flatten.map(&:skill_requests).flatten.select{|x| x.created_at > Time.now - 3.days && x.accepted_status != "confirmed"}
  end

end
