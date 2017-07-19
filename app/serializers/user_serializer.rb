class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name
  has_many :venues
end
