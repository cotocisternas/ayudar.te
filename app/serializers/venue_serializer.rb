class VenueSerializer < ActiveModel::Serializer
  attributes :id, :name, :desc, :tags, :location, :comments
  belongs_to :user

  attribute :image do
    {
      url: object.image.url,
      thumb: object.image.thumb.url,
      mime: object.image.file.content_type
    }
  end
end
