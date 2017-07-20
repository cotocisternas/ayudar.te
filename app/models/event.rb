class Event
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Enum
  include Mongoid::Taggable
  include Mongoid::Commentable
  include Mongoid::Geospatial


  field :name,                    type: String
  field :desc,                    type: String
  field :location,                type: Point, spatial: true
  field :recurrent,               type: Boolean, default: false
  field :duration,                type: Integer, default: -> { 1.hour }
  field :start_at,                type: DateTime, default: -> { Time.new }
  field :end_at,                  type: DateTime, default: -> { Time.new + duration }

  enum  :days, [:sun,:mon,:tue,:wed,:thu,:fri,:sat], multiple: true, default: -> {days_defaults}

  belongs_to :user

  validates :name,          presence: true, on: :create
  validates :location,      presence: true, on: :create

  def days_defaults
    [DateTime::ABBR_DAYNAMES[Date.today.wday].downcase.to_sym]
  end

end
