class Photo
  include Mongoid::Document
  include Mongoid::Timestamps
  include Voteable

  mount_uploader :image, ImageUploader

  embedded_in :event

  field :user_id, type: Integer
  field :user_name, type: String
  field :remote_image_url, type: String
  field :original_url, type: String

  before_destroy :delete_gfs!

  def delete_gfs!
    self.remove_image!
    self.save! validate: false
  end
end
