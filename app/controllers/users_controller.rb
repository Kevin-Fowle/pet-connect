class UsersController <  ApplicationController

  def new
  end

  def create
    @user = User.new(user_params)
    if params['organization_id']
      @organization = Organization.find(params['organization_id'])
      @user.organization_id = params['organization_id']
    end

    if @user.organization_user? && @user.save
      session[:user_id] = @user.id
      redirect_to organization_path(@organization)
    elsif @user.save
      session[:user_id] = @user.id
      redirect_to new_user_pet_path(@user)
    else
      @errors = @user.errors.full_messages
      render 'new'
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    @pets = @user.try(:pets)
    # @pet = Pet.find()
    @pairings = @user.try(:pairings)
    @organizations = []
    @pairings.try(:each) do |pair|
      @organizations << Organization.find(pair.organization_id)
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :street_address, :city, :zip_code, :state)
  end

end
