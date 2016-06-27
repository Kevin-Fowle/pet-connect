class MessagesController < ApplicationController 
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  before_action :set_pairing

  def index
    @messages = @pairing.messages
  end

  def show
  end

  def new
    @message = Message.new
  end

  def edit
  end

  def create
    parent = User.find(params[:user_id]).behalf_of

    @message = Message.new(message_params)
    @message.messageable = parent

    respond_to do |format|
      if @message.save
        format.html { redirect_to @message, notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: @Message }
      else
        format.html { render :new }
        format.json { render json: @Message.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
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