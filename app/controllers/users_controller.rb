class UsersController <  ApplicationController

def new
  @user = User.new
end

def create
  p user_params
  @user = User.new(user_params)
  if @user.save
    session[:user_id] = @user.id
    redirect_to(new_user_pet_path(@user))
  else
    render 'new'
  end
end

def show
  @user = User.find_by(id: params[:id])
  @pets = @user.pets
end

private

def user_params
  params.require(:user).permit(:first_name, :last_name, :email, :password, :street_address, :city, :zip_code, :state)
end

end
