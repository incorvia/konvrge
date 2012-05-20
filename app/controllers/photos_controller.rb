class PhotosController < ApplicationController

  before_filter :authenticate_user!, :only => [:create]

  def index
    order = order_translate(params[:sort])

    @event = Event.find(params[:event_id])
    @new_event = Event.new
    @new_photo = Photo.new
    photos = @event.photos.order(order => :desc).to_a
    @photos = Kaminari.paginate_array(photos).page(params[:page])
    session[:event_id] = @event.id
  end

  def create
    event = Event.find(session[:event_id])
    regex = /([^\s]+(\.(?i)(jpe?g|png|gif|bmp))$)/i

    if params[:photo][:remote_image_url] =~ regex
      new_photo = event.photos.new(params[:photo])
      new_photo.update_attributes(:original_url => params[:photo][:remote_image_url],
        :user_id => current_user.id,
        :user_name => current_user.name)
      new_photo.upvote(current_user)
    
      event.upvote(current_user)
      if event.save!
        flash[:notice] = "> You have successfully uploaded a photo!"
        redirect_to event_photos_path(event)
      end
    else
      flash[:notice] = "> Sorry, the image address you provided did not end in \'png\', \'gif\', \'jpg\', or \'jpeg\'"
      redirect_to event_photos_path(event)
    end
  end

private 

  def order_translate(order)
    case order
    when 'popular'
      return :vote_count
    when 'new'
      return :created_at
    end
  end
end
