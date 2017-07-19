class VenuesPaginator

  DEFAULT_SORTING = {created_at: :desc}
  SORTABLE_FIELDS = [:name, :created_at, :updated_at]

  delegate :params, to: :controller
  delegate :venues_url, to: :controller

  attr_reader :controller

  def initialize(controller)
    @controller = controller
  end

  def venues
    @venues ||= Venue.order(sort_params).page(current_page).per(per_page)
  end

  private
    def current_page
      (params.to_unsafe_h.dig('page', 'number') || 1).to_i
    end

    def per_page
      (params.to_unsafe_h.dig('page', 'size') || 10).to_i
    end

    def sort_params
      SortParams.sorted_fields(params[:sort], SORTABLE_FIELDS, DEFAULT_SORTING)
    end

    def rebuild_params
      @rebuild_params ||= begin
        rejected = ['action', 'controller']
        params.to_unsafe_h.reject { |key, value| rejected.include?(key.to_s) }
      end
    end
end
