class UsersController <  ApplicationController
  include UserHelper
  skip_before_action :require_login, only: [:new, :create, :show]
  def new
    @user = User.find_by(id: params[:id])
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
    redirect_to '/organizations/#{@user.organization_id}' if @user.organization_id
    @pets = @user.try(:pets)
    @rating = Rating.new
    @pairings = @user.try(:pairings)
    @organizations = []
    @pairings.try(:each) do |pair|
      @organizations << Organization.find(pair.organization_id)
    end
  end

  def text
    to = params[:to].gsub("-", "").gsub("\s", "")
    @body = params[:body]
    account_sid = "*********************************"
    auth_token = "*********************************"
    @client = Twilio::REST::Client.new account_sid, auth_token

    @client.account.messages.create({
      body: params[:textmessage],
      to: "+#{to}",
      from: "+12513336060",
      media_url: "#{lion}"
    }).status
      redirect_to 'show'


  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :cellphone, :password, :street_address, :city, :zip_code, :state)
  end

end
