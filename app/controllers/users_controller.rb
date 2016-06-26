class UsersController <  ApplicationController

def new
end

def create
  p user_params
  @user = User.new(user_params)
  if params['organization_id']
    @organization = Organization.find(params['organization_id'])
    @user.organization_id = params['organization_id']
  end

  if @user.save && @user.organization_id
    session[:user_id] = @user.id
    redirect_to(organization_path(@organization))
  elsif
    session[:user_id] = @user.id
    redirect_to(new_user_pet_path(@user))
  else
    @errors = @user.errors.full_messages
    render 'new'
  end
end

def show
  @user = User.find_by(id: params[:id])
  @pets = @user.pets
  @pairings = @user.pairings
  @organizations = []
  @pairings.each do |pair|
    @organizations << Organization.find(pair.organization_id)
  end
end

private

def user_params
  params.require(:user).permit(:first_name, :last_name, :email, :password, :street_address, :city, :zip_code, :state)
end

end
