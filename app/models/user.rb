class User
  include Mongoid::Document
  # encoding: utf-8

  field :email, type: String
  field :first_name, type: String
  field :last_name, type: String
  field :name, type: String
  field :fb_id, type: String
  field :token, type: String
  field :encrypted_password, type: String
  field :current_sign_in_at, type: String
  field :last_sign_in_at, type: String
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip, type: String
  field :sign_in_count, type: Integer
  field :remember_created_at, type: String
  field :username, type: String
  field :post_permission, type: Boolean

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, and :timeoutable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  embeds_many :friends

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :token,
  :first_name, :last_name, :fb_id, :name, :username, :post_permission

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    if user = User.where(:email => data.email).first
      user.update_info(access_token)
      user.update_fb_friends
      user
    else # Create a user with a stub password.
      user = User.create!(:email => data.email,
      :token => access_token.credentials.token,
      :password => Devise.friendly_token[0,20],
      :first_name => data.first_name,
      :last_name => data.last_name,
      :name => data.name,
      :fb_id => data.id,
      :post_permsision => true,
      :username => data.username)
      user.fb_friends
      user
    end
  end

  def update_info(auth)
    self.token = auth.credentials.token
    self.save!
  end

  def fb_friends
    graph = Koala::Facebook::API.new(self.token)
    friends = graph.get_connections("me", "friends")

    friends.each do |i|
      self.friends.create(:name => i["name"], :fb_id => i["id"])
    end
  end

  def update_fb_friends
    if !self.friends.last.nil?
      ids = self.friends_ids
      graph = Koala::Facebook::API.new(self.token)
      friends = graph.get_connections("me", "friends")
      friends.map! do |f| 
        if !ids.include?(f["id"])
          f
        end
      end

      friends.compact!

      friends.each do |i|
        self.friends.create(:name => i["name"], :fb_id => i["id"])
      end
    end
  end

  def process_friends_events(sort=nil, events=nil)
    ids = friends_ids
    events = Event.friends_events(ids).to_a if !events
    events = friends_data(events, ids)
    events
  end

  def friends_ids
    friends = User.where("_id" => self.id).only("friends.fb_id").first.friends
    ids = friends.map { |f| f.fb_id }
  end

  def friends_data(events, ids)
    events.map! do |x|
      intersect = x.up_voters & ids
      x.friend_count = intersect.count
      x.friend_score = Event.score_algorithm(x.friend_count, x.created_at)
      x.friend_voters = intersect
      x
    end
  end
end
