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
    @apprenticeships       = current_user.apprenticeships.includes(:skill,:location)
    @paths                 = current_user.paths
    @earning_skills        = current_user.created_skills.includes(:categories,:creator)
    @apprentice_requests   = current_user.apprentice_requests
    @upcoming_events       = current_user.confirmed_upcoming_events
    @skill_requests        = current_user.skill_requests.where(has_apprenticeship: false)
    @notifications         = current_user.notifications.includes(:notifiable).sort_by{|x| x.created_at}.reverse
    @open_requests         = @earning_skills.map(&:categories).flatten.map{|x| x.skill_requests.includes(:user)}.flatten.select{|x| x.created_at > Time.now - 3.days && x.accepted_status != "confirmed" && x.user != current_user }
  end

end
