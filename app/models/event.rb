class Event
  include Mongoid::Document
  include Mongoid::Timestamps
  include Voteable

  field :title, type: String
  field :location, type: String
  field :category, type: String
  field :category, type: String
  field :user_id, type: Integer
  field :user_name, type: String

  index :up_voters

  embeds_many :questions
  embeds_many :photos

  attr_accessor :friend_count
  attr_accessor :friend_score
  attr_accessor :friend_voters

  CATEGORIES = ['Harvard']

  scope :friends_events, lambda { |friends| where(:created_at.gte => (Date.today - 3)).any_in(up_voters: friends) }

  before_destroy :delete_gfs_photos!

  def self.score_algorithm(votes, created_at)
    (votes - 1) / (((Time.now - created_at) / 3600) + 2) ** 1.5
  end

  def self.process_votes
    @count = 0
    a = Event.all.to_a

    a.each do |i|
      i.score = Event.score_algorithm(i.vote_count, i.created_at)
      i.save; @count +=1;
    end

    RakeLog.create(:processed => @count.to_s, :status => '1')
  end

private

  def delete_gfs_photos!
    targets = self.photos
    targets.each do |i|
      i.delete_gfs!
    end
  end
end
