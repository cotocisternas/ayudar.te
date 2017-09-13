class UsersPaginator

  DEFAULT_SORTING = {create_list: :desc}
  SORTABLE_FIELDS = [:name]

  delegate :params, to: :controller

  attr_reader :controller

  def initialize(controller)
    @controller = controller
  end

  def users
    @users ||= User.order(sort_params).page(current_page).per(per_page)
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

end
