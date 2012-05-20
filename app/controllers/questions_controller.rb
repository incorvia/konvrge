class QuestionsController < ApplicationController
  before_filter :authenticate_user!, :only => [:create]

  def create
    event = Event.find(params[:question][:event_id])
    question = event.questions.new(params[:question])
    question.update_attributes!(:user_id => current_user.id, :user_name => current_user.name)
    question.upvote(current_user)
    event.upvote(current_user)
    if event.save
      flash[:notice] = '> You have successfully asked a question!'

      post_to_facebook(root_url.chomp('/') + event_path(event),
        event_path(event),
        {
          :message => "I just helped write this story:",
          :name => event.title,
          :caption => root_url.chomp('/') + event_path(event.id),
          :link => root_url.chomp('/') + event_path(event.id),  
          :picture => "http://www.konvrge.com/assets/fb_konvrge.png",
          :description => question.title
        }
      )
    end
  end
end
