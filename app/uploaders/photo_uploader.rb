class PhotoUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick

  storage :grid_fs

  process :resize_to_fit => [nil, 1080]
  process convert: 'jpg'

  version :thumb do
    process :resize_to_fit => [450, nil]
  end

  def store_dir
    "photos/#{model.class.to_s.underscore}/#{model.id}"
  end

  def content_type_whitelist
    /image\//
  end

  def filename
    secure_token(64) + '.jpg'
  end

  protected
    def secure_token(length=16)
      var = :"@#{mounted_as}_secure_token"
      model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.hex(length/2))
    end

end
