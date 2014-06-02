# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
PetulantOctoLana::Application.initialize!

ActionMailer::Base.smtp_settings = {
:address              => "10.8.0.1",
:port                 => 25,
:domain               => "sheraton"
}
