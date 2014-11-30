module SearchHelper


  def search_for(klass,params,options = {})
    search_hash = params[:search]
    @categories = search_hash[:categories].blank? ? "" : "AND categories.id IN (?)"
    query_string = "
      city LIKE ?
      AND state LIKE ?
      AND zip LIKE ?
      #{check_key(options,:ands){ |values|  values.inject(""){|x,y| x += " AND " + y[:string] }}}
      #{@categories ||= ''}"
    query = [query_string]
    search_hash[:location].keys.each do |k|
      query << blank_array?(search_hash[:location][k])
    end
    check_key(options,:ands){ |values|  query += values.inject([]){|x,y| x << y[:q] }}
    query << search_hash[:categories] if !@categories.blank?
    klass.joins(:location, :categories).where(*query).includes(:categories,:location)
  end

  private
  def check_key(options,key)
    if options.has_key?(key)
      values = options[key]
      yield(values)
    end
  end

  def blank_array?(hash)
    hash.blank? ? "%%" : hash
  end

end