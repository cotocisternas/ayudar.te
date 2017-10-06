class UserSerializer < ActiveModel::Serializer
  attributes :email, :name

  has_many :events
  has_many :venues
  has_many :identities
end
