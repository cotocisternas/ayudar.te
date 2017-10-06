class VenueSerializer < ActiveModel::Serializer
  attributes :name, :desc, :tags, :location, :comments

    attribute :image do
    {
      url: object.image.url,
      thumb: object.image.thumb.url,
      mime: object.image.file.content_type
    }
  end

  belongs_to :user
end
