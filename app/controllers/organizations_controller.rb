class OrganizationsController < ApplicationController
  def new
    @organization = Organization.new
  end

  def search
    input = "A"##params[:search]
    @organizations = Organization.where(["name = (?)", "#{input}%"])
  end


end
