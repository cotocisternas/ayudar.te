module Mongoid
  module Taggable
    extend ActiveSupport::Concern

    included do
      field :tags, type: Array, default: []
      index tags: 1

      def tags
        super || []
      end
    end

    class_methods do
      def all_tags(scope = {})
        map = %Q{
          function() {
            if(this.tags){
              this.tags.forEach(function(tag){
                emit(tag, 1)
              });
            }
          }
        }

        reduce = %Q{
          function(key, values) {
            var tag_count = 0 ;
            values.forEach(function(value) {
              tag_count += value;
            });
            return tag_count;
          }
        }

        tags = self
        tags = tags.where(scope) if scope.present?

        results = tags.map_reduce(map, reduce).out(inline: 1)
        results.to_a.map!{ |item| { :name => item['_id'], :count => item['value'].to_i } }
      end

      def tagged_with(tags)
        tags = [tags] unless tags.is_a? Array
        criteria.in(:tags => tags)
      end

      def tagged_without(tags)
        tags = [tags] unless tags.is_a? Array
        criteria.nin(:tags => tags)
      end

      def tagged_with_all(tags)
        tags = [tags] unless tags.is_a? Array
        criteria.all(:tags => tags)
      end

      def tag_list
        self.all_tags.collect{|tag| tag[:name]}
      end
    end

  end
end
