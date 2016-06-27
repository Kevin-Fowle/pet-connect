class RatingsController < ApplicationController
  def new
  end

  def create
    if params[:pet_id]
      rating = Rating.create(pet_rating_params)
    elsif params[:organization_id]
      rating = Rating.create(org_rating_params)
    end
  end

  private

  def pet_rating_params
    params.require(:rating).permit(:stars, :rating_id, :rating_type)
  end
end
