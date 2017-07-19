class VenuesController < ApplicationController
  before_action :set_venue, only: [:show, :update, :destroy]

  def index
    @venues = Venue.all
    json_response(@venues)
  end

  def create
    @venue = Venue.new(venue_attributes)

    if @venue.save
      json_response(@venue, :created, true)
    else
      json_error(@venue)
    end
  end

  def show
    json_response(@venue)
  end

  def update
    @venue.update(venue_params)
    head :no_content
  end

  def destroy
    @venue.destroy
    head :no_content
  end

  private
    def venue_params
      params.require(:data).permit(:type, {
        attributes: [:name, :description]
      })
    end

    def venue_attributes
      venue_params[:attributes] || {}
    end

    def set_venue
      @venue = Venue.find(params[:id])
    end

end
#
#
# def create
#     attributes = rental_unit_attributes.merge({user_id: auth_user.id})
#     @rental_unit = RentalUnit.new(attributes)
#
#     if @rental_unit.save
#       render json: @rental_unit, status: :created, location: @rental_unit
#     else
#       respond_with_errors(@rental_unit)
#     end
#   end
