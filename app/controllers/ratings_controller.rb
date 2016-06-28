class RatingsController < ApplicationController
  def new

  end

  def create
    if params[:ratable_type] == "Pet"
      p "***************************************"
      p pet_rating_params
      p "***************************************"
      @rating = Rating.create(stars: params[:stars], ratable_id: params[:ratable_id], ratable_type: params[:ratable_type])
      redirect_to '/'
    elsif params[:ratable_type] == "organization"
      @rating = Rating.create(org_rating_params)
    end
  end

  private

  def pet_rating_params
    params.permit(:stars, :ratable_id, :ratable_type, :pet_id, :user_id)
  end
end
