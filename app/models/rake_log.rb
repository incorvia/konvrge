class RakeLog
  include Mongoid::Document
  include Mongoid::Timestamps

  field :processed, type: String
  field :status, type: String
end
