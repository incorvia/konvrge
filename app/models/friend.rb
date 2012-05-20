class Friend
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :fb_id, type: String
  
  embedded_in :user
end
