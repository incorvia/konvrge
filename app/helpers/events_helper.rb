module EventsHelper
  def category_link(sort)
    if params[:category].nil?
      sort == 'popular' ? root_path : new_events_path
    else
      category_path(:category => params[:category], :sort => sort)
    end
  end

  def friends_category_visible?
    user_signed_in? ? true : false
  end

  def uniq_answer_id
     (Time.now.to_i.to_s + rand(100000).to_s).to_i
  end

  def current_vote(obj)
    votes = obj.votes
    votes = votes.drop_while {|v| v.fb_id != current_user.fb_id}
    !votes.empty? ? "up" : "nil"
  end

  def top_photo(event)
    if event.photos.count > 0
      (event.photos.order(:vote_count => :desc).first).image.normal.to_s
    else
      asset_path "event_default.png"
    end
  end

  def events_friended_paginated
    if params[:category] == 'friends'
      @events ||= []
    else
      events = @events.to_a
      events = current_user.process_friends_events(nil, events) if user_signed_in?
      events ||= []
    end
  end

  def paginator
    if @events.class == Array
      Kaminari.paginate_array(@events).page(params[:page])
    else
      @events
    end
  end
end
