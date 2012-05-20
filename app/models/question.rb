class Question
  include Mongoid::Document
  include Mongoid::Timestamps
  include Voteable

  field :title, type: String
  field :user_id, type: String
  field :user_name, type: String
  
  embedded_in :event
  embeds_many :answers
end
