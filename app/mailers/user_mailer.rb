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
    mail(to: @org_user.email, subject: 'Requested pet connect from #{@org_user.behalf_of.name}')
  end

  def scheduled_email(pet_owner, org_user)
    @pet_owner = pet_owner
    @org_user = org_user.behalf_of
    # @url  = 'http://example.com/login'
    mail(to: [@pet_owner.email, @org_user.email], subject: 'Pet connect scheduled')
  end

  def new_message_email(to_user, from_user)
    @to_user = to_user
    @message = @from_user.find_pairing(@to_user).messages.last
    mail(to: @to_user, subject: 'New message from #{@from_user.name}')
  end


end
