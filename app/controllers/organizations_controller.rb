class OrganizationsController < ApplicationController
  before_action :set_organization, only: [:show]

  def show
  end

  def new
    @organization = Organization.new
  end

  def search
    input = params[:search]
    upcase_input = input.upcase
    if request.xhr?
      @organizations = Organization.where('name LIKE ?', "#{upcase_input}%").limit(10)
  end

  private
    def set_organization
      @organization = Organization.find(params[:id])
    end

    def organization_params
      params.require(:oragnization).permit(:name, :street_address, :city, :zip_code, :state, :phone)
    end
end
