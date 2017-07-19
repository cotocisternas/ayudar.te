class VenuesController < ApplicationController

  before_action :set_venue, only: [:show, :update, :destroy]

  def index
    @venues = VenuesPaginator.new(self).venues
    json_response(@venues)
  end

  def show
    json_response(@venue)
  end

  def create
    @venue = Venue.new(venue_attributes)

    if @venue.save
      json_response(@venue, :created, true)
    else
      json_error(@venue)
    end
  end

  def update
    if @venue.update(venue_attributes)
      head :no_content
    else
      json_error(@venue)
    end
  end

  def destroy
    if @venue.destroy
      head :no_content
    else
      json_error(@venue)
    end
  end

  private
    def venue_attributes
      ActiveModelSerializers::Deserialization.jsonapi_parse(params)
    end

    def set_venue
      @venue = Venue.find(params[:id])
    end

end
