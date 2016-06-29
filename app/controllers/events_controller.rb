class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :set_user

  def index
    @events = @user.try(:events)
  end

  def show
  end

  def new
    if @user.pet_owner?
      @event = Event.new
    elsif @user.organization_user?
      organization = Organization.find(@user.behalf_of.id)
      redirect_to organization_path(organization)
    else
      redirect_to '/', notice: "You need to be logged in to see user's events"
    end
  end

  def edit
  end

  def Show
    @event = Event.find(params[:id])
  end

  def create
    if @user.pet_owner?
      @event = @user.events.new(event_params)

      respond_to do |format|
        if @event.save
          format.html { redirect_to user_events_path, notice: 'Event was successfully created.' }
          format.json { render :index, status: :created, location: @event }
        else
          format.html { render :new }
          format.json { render json: @event.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to '/', notice: "You need to be logged in as pet-owner to create event"
    end
  end

  def update
    @current_user = current_user

    p params['event']['accepted']
    if logged_in?
      if params['event']['accepted']
          @event.accepted = true
          @event.save
      end
      respond_to do |format|
        if @event.update(event_params)
          if current_user.pet_owner?

            UserMailer.scheduled_email(@user, @event.organization.representative).deliver_now

            format.html { redirect_to @user, notice: 'Event was successfully scheduled.' }
            format.json { render :index, status: :ok, location: @events }
          else

            UserMailer.requested_email(@user, @current_user).deliver_now

            format.html { redirect_to current_user.organization, notice: 'Event was successfully requested.' }
            format.json { render :show, status: :ok, location: @user }
          end
        else
          format.html { render :edit }
          format.json { render json: @event.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def destroy
    if logged_in? && current_user = @user
      @event.destroy
      respond_to do |format|
        format.html { redirect_to @user, notice: 'Event was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private
  def set_event
    @event = Event.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def event_params
    params.require(:event).permit(:date, :start_time, :end_time, :organization_id)
  end
end
