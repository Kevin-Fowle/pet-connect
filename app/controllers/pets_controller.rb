class PetsController <  ApplicationController
  def new
    @pet = Pet.new
    @user = User.find(params[:user_id])
  end

  def create
    @pet = Pet.new(pet_params)
    @user = User.find(params[:user_id])
    if @pet.save
      @pet.update(user_id: @user.id)
      redirect_to @user
    else
      render 'new'
    end
  end

  private

  def pet_params
    params.require(:pet).permit(:name, :species, :breed, :weight, :description, :user_id)
  end

end
