# Settings specified here will take precedence over those in config/environment.rb

# In the development environment your application's code is reloaded on
# every request.  This slows down response time but is perfect for development
# since you don't have to restart the webserver when you make code changes.
config.cache_classes = false

# Log error messages when you accidentally call methods on nil.
config.whiny_nils = true

# Show full error reports and disable caching
config.action_controller.consider_all_requests_local = true
config.action_view.debug_rjs                         = true
config.action_controller.perform_caching             = false

config.action_mailer.delivery_method = :smtp
config.action_mailer.smtp_settings = {
  :address	=> "localhost",
  :port		=> 25,
  :domain	=> "aesbus.com"
  }
config.action_mailer.perform_deliveries = true
# Don't care if the mailer can't send
config.action_mailer.raise_delivery_errors = false

# config.after_initialize do
#   ActiveMerchant::Billing::Base.gateway_mode = :test
# end

  # config.to_prepare do
  #   OrderTransaction.gateway =
  #     ActiveMerchant::Billing::AuthorizeNetGateway.new(
  #       :login => 'demo',
  #       :password => 'password'
  #     )
  # end

config.after_initialize do
  ActiveMerchant::Billing::Base.mode = :test
  paypal_options = {
    :login => "tomthemovingman-facilitator_api1.yahoo.com",
    :password => "1378528685",
    :signature => "ARE3Bcu.sqXO8B0C8JkRMe1LxaW8ACL0sVk8x1zobDvVjb6LY6jdya3l"
  }
  # ::STANDARD_GATEWAY = ActiveMerchant::Billing::PaypalGateway.new(paypal_options)
  ::EXPRESS_GATEWAY = ActiveMerchant::Billing::PaypalExpressGateway.new(paypal_options)
end