class EventsController < ActionController::Base
  include UserHelper

  def new
    @event = Event.new()
  end

  def create
    # start_time = Chronic.parse(params[:event]['start_time'])
    # p start_time
    # end_time = Chronic.parse(params[:event]['end_time'])
    @event = Event.new(event_params)
    @event.user_id = current_user.id
    if @event.save
      redirect_to current_user
    else
      redirect_to new_event
    end
  end

  private
  def event_params
    params.require(:event).permit(:start_time, :end_time, :acepted, :user, :organization)
  end
end
