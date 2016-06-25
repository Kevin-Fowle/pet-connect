class PairingsController < ApplicationController
  def new
  end

  def create
    @pairing = Pairing.new(pairing_params)
  end

  private

  def pairing_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :street_address, :city, :zip_code, :state)
  end
end
