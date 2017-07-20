class EventsController < ApplicationController

  before_action :set_event, only: [:show, :update, :destroy]

  def index
    @events = EventsPaginator.new(self).events
    json_response(@events)
  end

  def show
    json_response(@event)
  end

  def create
    @event = Event.new(event_attributes)

    if @event.save
      json_response(@event, :created, true)
    else
      json_error(@event)
    end
  end

  def update
    if @event.update(event_attributes)
      head :no_content
    else
      json_error(@event)
    end
  end

  def destroy
    @event.destroy
    head :no_content
  end

  private
    def event_attributes
      ActiveModelSerializers::Deserialization.jsonapi_parse(params)
    end

    def set_event
      @event = Event.find(params[:id])
    end

end
