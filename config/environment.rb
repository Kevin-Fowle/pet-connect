# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!


ActionMailer::Base.smtp_settings = {
  :user_name => 'petconnect',
  :password => 'MarleyandMe1',
  :domain => 'yourdomain.com',
  :address => 'smtp.sendgrid.net', 
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}