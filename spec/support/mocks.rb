# encoding: utf-8

# Facebook Authentication Hash for OmniAuth
OmniAuth.config.mock_auth[:facebook] = Hashie::Mash.new(
  :credentials => 
    {
      :expires => 'true',
      :expires_at => '1333126817',
      :token => 'ABCDEFG'
    },
  :extra =>
    {
      :raw_info => 
        {
          :email => 'incorvia@gmail.com',
          :first_name => 'Kevin',
          :gender => 'male',
          :id => '751080764',
          :last_name => 'Incorvia',
          :link => 'http://www.facebook.com/incorvia',
          :local => 'en_US',
          :location =>
            {
              :name => 'Cambridge, Massachusetts',
            },
          :name => 'Kevin Incorvia',
          :timezone => '-5',
          :updated_time => '2011-12-12T17:43:38+0000',
          :username => 'incorvia',
          :verified => 'true'
        }
    },
  :info =>
    {
      :email => 'incorvia@gmail.com',
      :first_name => 'Kevin',
      :image => 'http://graph.facebook.com/751080764/picture?type=square',
      :last_name => 'Incorvia',
      :location => 'Cambridge, Massachusetts',
      :name => 'Kevin Incorvia',
      :nickname => 'incorvia',
      :urls =>
        {
          :Facebook => 'http://www.facebook.com/incorvia'
        }
    },
  :provider => 'facebook',
  :uid => '751080764',

  # Custom key/values acting as mocks for Koala Requests
  :friends => [{"name"=>"hello world", "id"=>"124923"}, {"name"=>"Elaine Silver", "id"=>"125149"}, {"name"=>"Jonathan Bittner", "id"=>"301308"}, {"name"=>"Alessandra Montagnana", "id"=>"100003088881523"}]
)