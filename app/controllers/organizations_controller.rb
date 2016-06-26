
class OrganizationsController < ApplicationController
  # before_action :set_organization, only: [:show]
  def search
    @organizations = Organization.all
    p params
    input = params['name']
    upcase_input = input.upcase
    p upcase_input
    if input
      if request.xhr?
        @organizations = Organization.search(upcase_input)
        if (@organizations.length > 0 && logged_in?)
          render partial: 'organizations/partial_user_search', :layout => false
        elsif @organizations.length > 0
          render partial: 'organizations/partial_search_with_links', :layout => false
        end
      end
    end
  end

  def show
  end

  def new
    # @organization = Organization.new
  end

  def create

    @organization = Organization.find_by(name: params['name'])
    p @organization
    render partial: 'new_org_user'
    # redirect_to "/users/new?organization_id=#{@organization.id}"

  end

  private

    def set_organization
      @organization = Organization.find(params[:id])
    end

    def organization_params
      params.require(:oragnization).permit(:name, :street_address, :city, :zip_code, :state, :phone)
    end
end
