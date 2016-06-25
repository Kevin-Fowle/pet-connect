
class OrganizationsController < ApplicationController
  before_action :set_organization, only: [:show]
  def search
    @organizations = Organization.all
    input = params["name"]
    upcase_input = input.upcase
    p upcase_input
    if input
      if request.xhr?
        @organizations = Organization.search(upcase_input)
        if @organizations.length > 0
          render partial: 'organizations/partial_search', :layout => false
        else
          'WTF!?'
        end
      end
    end
  end

  def show
  end

  def new
    @organization = Organization.new
  end

  def create

  end

  private

    def set_organization
      @organization = Organization.find(params[:id])
    end

    def organization_params
      params.require(:oragnization).permit(:name, :street_address, :city, :zip_code, :state, :phone)
    end
end
