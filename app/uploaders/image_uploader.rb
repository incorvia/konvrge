class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  version :normal do
    process :resize_to_fill => [150,100]
  end

  version :wall do
    process :resize_to_fill => [186,124]
  end

  def store_dir
    "#{model.class.to_s.underscore}/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end