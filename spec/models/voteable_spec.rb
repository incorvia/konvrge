require 'spec_helper'

describe "Voteable" do
  describe "voting on events" do
    before :each do 
      @event = Factory(:event)
      @user = Factory(:user)
    end

   describe "upvote" do
      it "should increment an events vote_count" do
        lambda do
          @event.upvote(@user)
        end.should change(@event, :vote_count).from(0).to(1)
      end
    end

    describe "upvote_toggle" do
      it "should decrement an events vote_count" do
       @event.upvote(@user)
        lambda do
          @event.upvote_toggle(@user)
        end.should change(@event, :vote_count).from(1).to(0)
      end
    end
  end

  describe "voting on questions" do
    before :each do 
      @event = Factory(:event)
      @question = @event.questions.first
      @user = Factory(:user)
    end

   describe "upvote" do
      it "should increment a questions vote_count" do
        lambda do
          @question.upvote(@user)
        end.should change(@question, :vote_count).from(0).to(1)
      end
    end

    describe "upvote_toggle" do
      it "should decrement an questions vote_count" do
       @question.upvote(@user)
        lambda do
          @question.upvote_toggle(@user)
        end.should change(@question, :vote_count).from(1).to(0)
      end
    end
  end
end


