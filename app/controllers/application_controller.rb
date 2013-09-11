# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
 # include SslRequirement
  layout "moveu"
  #before_filter :authorize, :except => [:login,:signup,:payment_success,:new,:enter_coupon,:forgot,:choose_subscription]
  helper :all # include all helpers, all the time

  before_filter {puts "\n"*10 + 'start of Application Controller'} #debug

#  p 'start of ApplicationController' #debug
#  if session then
#    session[:myvar] = 'my session variable' #debug
#    y session  #debug
#  end
  

protected
  def authorize
    @company = Company.find_by_id(session[:company_id]) 
    unless (@company &&  @company.active?)
      flash[:notice] = "Please log in"
      redirect_to :controller => 'admin', :action => 'login'
    end
  end
end
