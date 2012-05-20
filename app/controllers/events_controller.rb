class EventsController < ApplicationController
  before_filter :authenticate_user!, :only => [:create, :vote]
  before_filter :store_location, :only => [:index]

  def index
    @new_event = Event.new
    order = order_translate(params[:sort])

    if params[:category] == 'friends'
      if user_signed_in?
        if order == :score
          order = :friend_score
        end
        @events = current_user.process_friends_events(order, nil)
        @events = events_sort(@events, order)
        @events = Kaminari.paginate_array(@events).page(params[:page]).per(10)
      else
        redirect_to root_path
      end
    elsif params[:category]
      @events = Event.where(:category => params[:category].camelcase).order(order => :desc).page(params[:page])
    else
      @events = Event.all.order(order => :desc).page(params[:page])
    end
  end

  def show
    @new_event = Event.new
    @new_question = Question.new
    @new_photo = Photo.new

    @event = Event.find(params[:id])
    @questions = @event.questions
    @top_photos = @event.photos.order(:vote_count => :desc).limit(3)
    session[:event_id] = @event.id
  end

  def create
    event = Event.new(params[:event])
    if event.title.empty? || event.location.empty?
      flash[:notice] = "> An event must have both a title and location."
      redirect_to root_path
    else
      event.upvote(current_user)
      event.update_attributes(:user_name => current_user.name, :user_id => current_user.id)

      if event.save!
        flash[:notice] = "> You have successfully posted a news event!"

        post_to_facebook(root_url.chomp('/') + event_path(event),
          event_path(event),
          {
            :message => "I just reported a news event on Konvrge:",
            :name => event.title, 
            :link => root_url.chomp('/') + event_path(event),
            :caption => root_url.chomp('/'),
            :picture => "http://www.konvrge.com/assets/fb_konvrge.png",
            :description => event.location
          }
        )
      end 
    end
  end

  def vote
    model = params["vote"]["model"].camelize.constantize
    event = Event.find(session[:event_id])
    event.upvote(current_user)
    event.save!

    case model.to_s
    when "Event"
      return;
    when "Question"
      question = event.questions.find(params[:vote][:id])
      question.upvote_toggle(current_user)
      question.save!
    when "Answer"
      question = event.questions.find(params[:vote][:question_id])
      answer = question.answers.find(params[:vote][:id])
      answer.upvote_toggle(current_user)
      answer.save!
    when "Photo"
      photo = event.photos.find(params[:vote][:id])
      photo.upvote_toggle(current_user)
      photo.save!
    end
    render :nothing => true
  end

private

  def order_translate(order)
    case order
    when 'popular'
      return :score
    when 'new'
      return :created_at
    end
  end

  def events_sort(events, order)
    events.sort_by!(&order)
    events.reverse!
  end

end
