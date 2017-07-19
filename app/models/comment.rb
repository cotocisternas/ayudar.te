class Comment
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :user_id,                 type: BSON::ObjectId
  field :user_name,               type: String
  field :comment,                 type: String

  attr_accessor :user

  embedded_in :commentable, polymorphic: true
  embeds_many :comments, :as => :commentable, cascade_callbacks: true

  before_create :set_params

  validates :user,        :presence => {:on => :create}
  validates :comment,     :presence => {:on => :create}

  private
    def set_params
      self.user_id            = self.user.id
      self.user_name          = self.user.name
    end
end
