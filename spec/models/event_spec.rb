require 'spec_helper'

describe Event do
  it 'should have an Event model' do
    event = Event.new
  end

  describe "rake" do
    before (:each) do
      @event = Factory(:event, :vote_count => 4, :score => 0)
      @event2 = Factory(:event, :vote_count => 9, :score => 0)
    end
      
    it "should set the scores for all items" do
      Event.process_votes
      @event.reload
      @event2.reload
      @event.score.should_not == 4
      @event2.score.should_not == 9
      @event2.score.should > 0
      @event.score.should > 0
      @event2.score.should > @event.score
    end
  end
  # Tests for Voteable Module

  describe "Voteable" do
    before :each do
      @event = Factory(:event)
      @user = Factory(:user)
    end

    describe "upvote" do
      it "should increase the vote count" do
        lambda { @event.upvote(@user) }.should change(@event, :vote_count).from(0).to(1)
      end

      it "should not descrease the vote count on upvote when vote present" do
        lambda { @event.upvote(@user) }.should_not change(@event, :vote_count).from(1).to(0)
      end
    end

    describe "upvote_toggle" do
      it "should descrease the vote count on upvote_toggle when vote present" do
        @event.upvote(@user)
        lambda { @event.upvote_toggle(@user) }.should change(@event, :vote_count).from(1).to(0)
      end
    end

    describe "current_vote" do
      it "should return the current vote" do
        @event.upvote(@user)
        @event.current_vote(@user) == :up
      end

      it "should return the current vote" do
        @event.current_vote(@user) == nil
      end
    end
  end
end
