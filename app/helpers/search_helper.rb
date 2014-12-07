module SearchHelper

  def search_for(klass,params,options = {})
    params[:search] ||= {location:{},categories:''}
    location_ids = Location.where(params[:search][:location].compact_blanks).pluck('id')
    category_ids = Category.where(id:params[:search][:categories]).pluck(:id)
    items_found = case
      when !location_ids.empty? && !category_ids.empty?
        klass.in_location(location_ids).in_categories(category_ids)
      when location_ids.empty? && !category_ids.empty?
        klass.in_categories(category_ids)
      when category_ids.empty? && !location_ids.empty?
        klass.in_location(location_ids)
      else
        klass
    end
  end

end