module SearchHelper

  def search_for(klass,params,options = {})
    params[:search] ||= {search: {location:{},categories:''}}
    params[:search][:location] = params[:search][:location].respond_to?(:compact_blanks) ? params[:search][:location] : {}
    location_ids = Location.where(params[:search][:location].compact_blanks).pluck('id')
    category_ids = Category.where(id:params[:search][:categories]).pluck(:id)
    items_found = case
      when !location_ids.empty? && !category_ids.empty?
        klass.in_location(location_ids).in_categories(category_ids)
      when location_ids.empty? && !category_ids.empty?
        klass.in_categories(category_ids)
      when category_ids.empty? && !location_ids.empty?
        klass.in_location(location_ids)
      when category_ids.empty? && location_ids.empty?
        klass
    end
    klass_search_attributes(items_found)
  end

  def klass_search_attributes(items_found)
    if items_found.respond_to?(:to_a)
      items_found.search
    else
      []
    end
  end

end