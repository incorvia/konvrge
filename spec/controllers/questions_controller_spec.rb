require 'spec_helper'
require 'ruby-debug'

describe QuestionsController do
  describe 'questions#Create' do 

    before(:each) do
      @event = Factory(:event)
      @user = Factory(:user)
      sign_in @user
    end

    it 'should redirect' do
      post "create", :question => {:title => "hello", :event_id => @event.id}
      response.code.should == "302"
    end

    it 'should upvote the event' do
      post "create", :question => {:title => "hello", :event_id => @event.id}
      Event.first.vote_count.should == 1
      Event.first.up_voters.should include(@user.fb_id)
    end
  end
end
