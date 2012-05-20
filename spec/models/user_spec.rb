require 'spec_helper'
require 'ruby-debug'

describe User do
	describe "Registering" do
		before do 
		  @auth = OmniAuth.config.mock_auth[:facebook]
			facebook_friends
		end

		describe 'associations' do
			it "should have a friends method" do
				user = Factory(:user)
				user.friends
			end
		end

		describe "registering new user" do
		  it "should persist info" do
		  	user = User.find_for_facebook_oauth(@auth)
		  	user.email.should == 'incorvia@gmail.com'
		  	user.first_name.should == 'Kevin'
		  	user.last_name.should == 'Incorvia'
		  	user.name.should == 'Kevin Incorvia'
		  	user.fb_id.should == '751080764'
		  	user.username.should == 'incorvia'
		  end
		end

		describe 'registering exisiting user' do
			it "should write a new token" do
				user = Factory(:user, :token => '1234')
				User.find_for_facebook_oauth(@auth)
				user.reload
				user.token.should == 'ABCDEFG'
			end
		end

		describe 'fb_friends' do
			it "should create friends" do
				@user = Factory(:user)
				@user.fb_friends
				@user.friends.count.should == 440
			end
		end
	end

	describe "friends_ids" do
		it "should return an array of ids" do
			@user = Factory(:user)
			5.times { @user.friends.create(:fb_id => Factory.next(:fb_id), :name => Faker::Name.name) }
			results = @user.friends_ids
			results.each do |i|
				i.should match /\d{7}/
			end
		end
	end

	describe "friends_data" do
		before (:each) do
			@user = Factory(:user)
			@non_friend = Factory(:user, :email => Faker::Internet.email, :name => Faker::Name.name, :fb_id => Factory.next(:fb_id))
			
			@friends = 4.times.map do |i|
  			@user.friends.create(:fb_id => Factory.next(:fb_id), :name => Faker::Name.name)
			end

			@events = 4.times.map do |i|
  			Factory(:event, :title => Faker::Lorem.sentence)
			end

			@events[0].upvote(@user); @events[0].save
			@events[0].upvote(@friends[0]); @events[0].save
			@events[1].upvote(@friends[0]); @events[1].save
			@events[1].upvote(@friends[1]); @events[1].save
			@events[1].upvote(@non_friend); @events[1].save
			@events[2].upvote(@friends[2]); @events[2].save

			@ids = @user.friends_ids
		end

		it "should return a set of events" do
			events = Event.friends_events(@ids).to_a
			events = @user.friends_data(events, @ids)
			events.should =~ (@events - @events[3].to_a)
		end

		it "should return events with a friend_count & correct count" do
			events = Event.friends_events(@ids).to_a
			events = @user.friends_data(events, @ids)
			events.each do |i|
			   i.friend_count.should == 2 if i.id == @events[1].id
			end
		end

		it "should return events with a score" do
			events = Event.friends_events(@ids).to_a
			events = @user.friends_data(events, @ids)
			events.each do |i|
				 i.friend_score.should > 0 if i.id == @events[1].id
			end
		end

		it "friends_voters should container users friends" do
			events = Event.friends_events(@ids).to_a
			events = @user.friends_data(events, @ids)
			events.each do |i|
				if i.id == @events[1].id
					i.friend_voters.should include(@friends[1].fb_id, @friends[0].fb_id)
				end
			end
		end

		it "friends_voters should not container non-friends" do
			events = Event.friends_events(@ids).to_a
			events = @user.friends_data(events, @ids)
			events.each do |i|
				if i.id == @events[1].id
					i.friend_voters.should_not include(@non_friend.fb_id, @friends[2].fb_id)
				end
			end
		end
	end
end
