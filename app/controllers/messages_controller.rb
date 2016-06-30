class MessagesController < ApplicationController 
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  before_action :set_pairing

  def index
    if logged_in?
      @messages = @pairing.try(:messages)
    else
      redirect_to '/login'
    end
    # redirect_to current_user.behalf_of show if @messages.try(:length) < 1
  end

  def show
  end

  def new
    @message = Message.new
  end

  def edit
  end

  def create
    parent = User.find_by(id: current_user.id).behalf_of

    if current_user.organization_user?
      @pair = @pairing.pet_owner
    else
      @pair = @pairing.organization
    end

    @message = @pairing.messages.new(message_params)
    @message.messageable = parent

    respond_to do |format|
      if @message.save
        UserMailer.new_message_email(@pair, current_user).deliver_now

        format.html { redirect_to pairing_messages_path(@pairing), notice: 'Message was successfully created.' }
        format.json { render :index, status: :created, location: pairing_messages_path(@pairing) }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @messages, notice: 'Message was successfully updated.' }
        format.json { render :index, status: :ok, location: @messages }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_message
    @message = Message.find(params[:id])
  end

  def set_pairing
    @pairing = Pairing.find(params[:pairing_id])
  end

  def message_params
    params.require(:message).permit(:subject, :body)
  end
end