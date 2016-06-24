class PetsController <  ApplicationController
  def new
    @pet = Pet.new
    @user = User.find(params[:user_id])
  end

  def create
    @pet = Pet.new
    if @pet.save
      redirect_to @user
    else
      render 'new'
    end
  end

end
