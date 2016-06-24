class OrganizationsController < ApplicationController
  def new
    @organization = Organization.new
  end

end
