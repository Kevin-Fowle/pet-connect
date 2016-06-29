class PairingsController < ApplicationController
  before_action :set_pairing, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token

  def new
  end
  
  def index
    if logged_in?
      @pairings = current_user.behalf_of.try(:pairings)
    else
      redirect_to '/login'
    end
  end

  def show
  end

  def create
    @organization = Organization.find(params[:organization_id])
    @user = current_user
    @pairing = Pairing.new(organization: @organization)
    @pairing.user_id = current_user.id
     respond_to do |format|
      if @pairing.save
        format.html { redirect_to current_user, notice: 'Preferred hospital successfully added' }
        format.json { render :index, status: :ok }
      else
        format.html { redirect_to current_user, notice: 'Preferred hospital not added' }
        format.json { render json: @pairing.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @pairing =Pairing.find(params[:id])
    @organization = Organization.find(params[:organization_id])
    @pairing.org_approved = true
    redirect_to @organization if @pairing.save
  end

  def destroy
    @pairing = Pairing.find(params[:id])
    @organization = Organization.find(params[:organization_id])
    @pairing.destroy
    redirect_to @organization

  end

  private

  def set_pairing
    @pairing = Pairing.find(params[:id])
  end

  def pairing_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :street_address, :city, :zip_code, :state)
  end
end
