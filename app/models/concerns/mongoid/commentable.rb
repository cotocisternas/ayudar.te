module Mongoid
  module Commentable
    extend ActiveSupport::Concern

    included do
      embeds_many :comments, :as => :commentable, cascade_callbacks: true
      accepts_nested_attributes_for :comments,  :autosave => true, allow_destroy: true
    end

  end
end
