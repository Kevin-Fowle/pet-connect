class UserMailer < ApplicationMailer
  default from: 'pet.connect@outlook.com'

  def welcome_email(user)
    @user = user
    # @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

  def requested_email(pet_owner, org_user)
    @pet_owner = pet_owner
    @org_user = org_user
    # @url  = 'http://example.com/login'
    mail(to: [@pet_owner.email, @org_user.email], subject: 'Requested pet connect')
  end

  def scheduled_email(pet_owner, org_user)
    @pet_owner = pet_owner
    @org_user = org_user
    # @url  = 'http://example.com/login'
    mail(to: [@pet_owner.email, @org_user.email], subject: 'Pet connect scheduled')
  end


end
