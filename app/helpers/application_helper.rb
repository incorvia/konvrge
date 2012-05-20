module ApplicationHelper
  def category_status(category)
    if params[:action] == 'index'
      "active" if params[:category] == category
    elsif params[:action] == 'show'
      "active" if @event.category == category.camelcase unless category.nil?
    end
  end

  def sort_status(sort)
    "active" if params[:sort] == sort
  end
end
