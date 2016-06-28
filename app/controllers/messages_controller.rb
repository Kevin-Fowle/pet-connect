class MessagesController < ApplicationController 
  before_action :set_message, only: [:edit, :update, :destroy]
  before_action :set_pairing, except: [:index]

  def index
    if logged_in?
      @conversations = current_user.behalf_of.conversations(current_user)
    end
    # redirect_to current_user.behalf_of show if @messages.try(:length) < 1
  end

  def show
    @messages = @pairing.try(:messages)
  end

  def new
    @message = Message.new
  end

  def edit
  end

  def create
    parent = User.find_by(id: current_user.id).behalf_of

    @message = @pairing.messages.new(message_params)
    @message.messageable = parent

    respond_to do |format|
      if @message.save
        format.html { redirect_to pairing_messages_path, notice: 'Message was successfully created.' }
        format.json { render :index, status: :created, location: @message }
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