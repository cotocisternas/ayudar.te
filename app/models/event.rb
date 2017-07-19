class Event
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Taggable
  include Mongoid::Commentable
  include Mongoid::Geospatial


  field :name,                    type: String
  field :desc,                    type: String
  field :location,                type: Point, spatial: true

  belongs_to  :user

  validates :name,          presence: true, on: :create
  validates :location,      presence: true, on: :create

end
