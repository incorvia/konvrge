# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rspec'
require 'omniauth'
require 'factory_girl_rails'
require 'webmock/rspec'


# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  # config.use_transactional_fixtures = false

  # Mongoid
  config.include Mongoid::Matchers, :type => :model

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  #Capybara
  Capybara.ignore_hidden_elements = true
  Capybara.javascript_driver = :webkit

  # Devise Test helpers
  config.include Devise::TestHelpers, :type => :controller

  # WebMock
  WebMock.disable_net_connect!(:allow_localhost => true)

  # OmniAuth Test Mode
  OmniAuth.config.test_mode = true

  # Database Cleaner
  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.orm = "mongoid"
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

def facebook_friends
  stub_request(:get, "https://graph.facebook.com/me/friends?access_token=ABCDEFG").
      with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
      to_return(lambda { |request| File.new("#{Rails.root}/spec/support/fb_friends.txt" )})
end

def check_fb
  stub_request(:get, "https://graph.facebook.com/me/permissions?access_token=ABCDEFG").
      with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => "{\"data\":[{\"installed\":1,\"status_update\":1,\"photo_upload\":1,\"video_upload\":1,\"email\":1,\"create_note\":1,\"share_item\":1,\"publish_stream\":1}]}", :headers => {})
end


