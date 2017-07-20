class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :desc, :tags, :location, :recurrent, :duration, :days, :start_at, :end_at, :comments
  belongs_to :user
end
