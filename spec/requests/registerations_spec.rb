require 'spec_helper'

describe "Registerations" do
  before :each do
    facebook_friends
    check_fb
  end

  it "sign a user in" do
    visit '/'
    click_link 'Sign in with Facebook'
    page.should have_link('Logout')
  end

  it "should sign a user out", :js => true do
    visit '/'
    click_link 'Sign in with Facebook'
    click_link 'My Account'
    click_link 'Logout'
    page.should have_content('Sign in with Facebook')
  end
end
