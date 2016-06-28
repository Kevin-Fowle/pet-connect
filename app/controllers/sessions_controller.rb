class SessionsController <  ApplicationController
  def new
    render :template => "sessions/new", :layout => false
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to '/'
  end

end
