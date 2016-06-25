
class OrganizationsController < ApplicationController
  before_action :set_organization, only: [:show]
  def search
    @organizations = Organization.all
    p params
    input = params['name']
    # p input
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

  # def search
  #   input = params[:search]
  #   upcase_input = input.upcase
  #   if request.xhr?
  #     @organizations = Organization.where('name LIKE ?', "#{upcase_input}%").limit(10)
  #   end
  # end

  private

    def set_organization
      @organization = Organization.find(params[:id])
    end

    def organization_params
      params.require(:oragnization).permit(:name, :street_address, :city, :zip_code, :state, :phone)
    end
end
