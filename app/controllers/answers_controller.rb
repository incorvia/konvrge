class AnswersController < ApplicationController
  before_filter :authenticate_user!, :only => :create

  def create
    event = Event.find(params[:answer][:event_id])
    question = event.questions.find(params[:answer][:question_id])
    answer = question.answers.new(params[:answer])
    answer.update_attributes(:user_id => current_user.id, :user_name => current_user.name)
    answer.upvote(current_user)
    event.upvote(current_user)
    if event.save!
      flash[:notice] = "> You've successfully posted your answer!"

      post_to_facebook(root_url.chomp('/') + event_path(event),
        event_path(event),
        {
          :message => "I just helped write this story:",
          :name => event.title, 
          :caption => root_url.chomp('/'),
          :link => root_url.chomp('/') + event_path(event.id),  
          :picture => "http://www.konvrge.com/assets/fb_konvrge.png",
          :description => answer.content
        }
      )

      UserMailer.notify_answer_reply(User.find(question.user_id), event_path(event)).deliver
    end
  end
end