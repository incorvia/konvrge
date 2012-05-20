require 'spec_helper'

describe "Event Feed" do
  before(:each) do
    facebook_friends
    check_fb
  end

  it 'should exist' do
    visit root_path
  end

  it 'should have category routes' do
    visit '/c/local/popular'
  end

  it 'should have a local sort route' do
    visit '/c/local/new'
  end

  describe "Header" do
    before :each do
      visit '/'
      click_link 'Sign in with Facebook'
    end

    it "should have a 'Report News' link", :js => true do
      page.should have_content 'Report News'
    end
  end

  describe "Report News", :js => true do
    before :each do
      visit '/'
      click_link 'Sign in with Facebook'
    end

    it "should have a 'what happened' field", :js => true do
      click_link 'Report News'
      page.should have_field('What happened?')
    end

    it "should have a 'Where? field", :js => true do
      click_link 'Report News'
      page.should have_field('Where?')
    end
  end

  describe "Friend Count" do
    before :each do
      visit '/'
      click_link 'Sign in with Facebook'
    end

    it "Should not show friends count on popular feed when logged out", :js => true do
      click_link 'Report News'
      fill_in 'What happened?', :with => 'Test Event'
      fill_in 'Where?', :with => 'Moon'
      click_button 'Submit'
      click_link 'My Account'
      click_link 'Logout'
      within('.friends') do
       page.should have_content('-')
      end
    end 
  end

  describe "Category Menubar", :js => true do
    it "should hide friends link when logged out" do
      visit '/'

      within('#menu') do
        page.should_not have_content('Friends')
      end

      click_link 'Sign in with Facebook'

      within('#menu') do
        page.should have_content('Friends')
      end
    end

    it "should display valid links" do
      visit '/'
      within('#menu') do
        page.should have_link('Popular', :href => '/')
        page.should have_link('New', :href => '/new')
      end

      click_link 'Politics'
      within('#menu') do
        page.should have_link('Popular', :href => '/c/politics/popular')
        page.should have_link('New', :href => '/c/politics/new')
      end
    end
  end
end