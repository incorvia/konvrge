class Answer
  include Mongoid::Document
  include Mongoid::Timestamps
  include Voteable

  field :content, type: String
  field :user_id, type: String
  field :user_name, type: String

  embedded_in :question
end
