class VenueSerializer < ActiveModel::Serializer
  attributes :id, :name, :desc, :tags, :location, :comments
  belongs_to :user

  # attribute :comments do
  #   object.comments
  # end
end
