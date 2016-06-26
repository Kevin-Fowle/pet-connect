class PairingsController < ApplicationController
  def new
  end

  def create
    @organization = Organization.find(params[:id])
    @pairing = current_user.pairings.new(organization: @organization)
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

  private

  def pairing_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :street_address, :city, :zip_code, :state)
  end
end
