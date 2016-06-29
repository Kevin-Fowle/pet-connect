class OrganizationsController < ApplicationController
  skip_before_action :require_login, only: [:search, :new, :show, :create]
  def search
    @organizations = Organization.all
    input = params['name']
    upcase_input = input.upcase
    p params
    if input
      if request.xhr?
        @organizations = Organization.search(upcase_input)
        if (@organizations.length > 0 && logged_in?)
          render partial: 'organizations/partial_user_search', :layout => false
        elsif @organizations.length > 0
          render partial: 'organizations/partial_search_with_links', :layout => false
        else
          render json: "No results found"
        end
      end
    end
  end

  def show
    current_user
    @organization = Organization.find(params[:id])
    # @pending_pairings = Pairing.where(active: true, org_approved: false, organization_id: params[:id])
    # p @pending_pairings
  end

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.find_by(name: params['name'])
    @user = User.new(user_params)
    @user.organization_id = @organization.id
    @user.save
    session[:user_id] = @user.id

    redirect_to @organization

  end

  private
    def set_organization
      @organization = Organization.find(params[:id])
    end

    def organization_params
      params.require(:oragnization).permit(:name, :street_address, :city, :zip_code, :state, :phone)
    end
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :street_address, :city, :zip_code, :state)
    end
end
