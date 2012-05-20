require 'spec_helper'
require 'ruby-debug'

describe EventsController do
  it "Should have a index action" do
    get 'index', :sort => 'popular'
  end

  describe "events#Index" do
    before (:each) do
      4.times {Factory.create(:event, :score => rand(1..10), :created_at =>  Factory.next(:created_at))}
    end

    describe "all" do
      it "should return events sorted by score" do
        get "index", :sort => 'popular'
        events = assigns[:events].to_a
        events[0].score.should >= events[1].score
        events[1].score.should >= events[2].score
        events[2].score.should >= events[3].score
      end

      it "should return events sorted by date" do
        get "index", :sort => 'new'
        events = assigns[:events].to_a
        events[0].created_at.should > events[1].created_at
        events[1].created_at.should > events[2].created_at
        events[2].created_at.should > events[3].created_at
      end
    end
  end

  describe "events#Create" do
  	it "should create a new Event" do
      @user = Factory(:user)
      sign_in @user

  	  lambda do
  	    post :create, :event => { 
                                  :title => 'Konvrge wins best website award', 
	  	  												  :location => 'Mountain View, CA',
                                  :category => 'Politics' 
                                }
	  	end.should change(Event, :count).by(1)
  	end
  end
end
