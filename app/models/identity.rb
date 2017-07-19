class Identity
  include Mongoid::Document
  include Mongoid::Timestamps

  field :provider,                type: String
  field :uid,                     type: String

  embedded_in :user

  validates :provider,      presence: true
  validates :uid,           presence: true
  validates :uid,           uniqueness: { scope: :provider }

end
