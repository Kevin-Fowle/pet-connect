class MessagesController < ApplicationController 
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  def index
    @messages = Message.all
  end

  def show
  end

  def new
    @Message = Message.new
  end

  def edit
  end

  def create
    if params[:user_id]
      parent = User.find(params[:user_id])
    elsif params[:organization_id]
      parent = Organization.find(params[:organization_id])
    end
    @message = Message.new(message_params)
    @message.messageable = parent

    respond_to do |format|
      if @message.save
        format.html { redirect_to @message, notice: 'Message was successfully created.' }
        # format.json { render :show, status: :created, location: @Message }
      else
        format.html { render :new }
        # format.json { render json: @Message.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        # format.json { render :show, status: :ok, location: @Message }
      else
        format.html { render :edit }
        # format.json { render json: @Message.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @Mmssage.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      # format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:title, :body, :published)
    end
end