require 'spec_helper'

describe "QA" do
  before(:each) do
    facebook_friends
    check_fb
    visit '/'
    click_link 'Sign in with Facebook'
    click_link 'Report News'
    fill_in 'What happened?', :with => 'Test Event'
    fill_in 'Where?', :with => 'Moon'
    click_button 'Submit'
  end

  describe "Posting a question", :js => true do
    it "should not have a 'ask' form if not logged in" do
      click_link 'My Account'
      click_link 'Logout'
      click_link 'Test Event'
      page.should_not have_css('.question-ask')
    end
  end

  describe "Photos", :js => true do
    describe "Modal" do
      it "should have a 'Image Address' field when logged in" do
        click_link 'Report News'
        page.should have_field('What happened?')
      end
    end

    it "should not show the new photo icon when not logged in" do
      click_link 'My Account'
      click_link 'Logout'
      click_link 'Test Event'
      save_and_open_page
      page.should_not have_css("img[src*='/new-photo.png']")
    end
  end
end
