class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :desc, :tags, :location, :recurrent, :duration, :days, :start_at, :end_at, :comments
  belongs_to :user

  attribute :image do
    {
      url: object.image.url,
      thumb: object.image.thumb.url,
      mime: object.image.file.content_type
    }
  end
end
