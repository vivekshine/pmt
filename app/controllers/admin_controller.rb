class AdminController < ApplicationController

#  y request.session_options

  def login
    if request.post?
      puts "\n" * 4 + 'admin login top' #debug
      company = Company.authenticate(params[:adminlogin], params[:password])
      if company
        session[:company_id] = company.id
        session[:company] = company
        p 'admin login'; y session #debug
        # Where should we go once logged in?
        redirect_to(:action => "index")
      else
        flash.now[:notice] = "Login failed"
      end
    end
  end

  def logout
    session[:company_id] = nil
        y session #debug
    flash[:notice] = "Logged out"
    redirect_to(:action => "login")
  end

  def index
    id = session[:company_id]
    @thiscompany = Company.find(id)
    @total_users = User.count(:conditions => ["company = ?", @thiscompany.id])
    puts "\n\n\n @thiscompany.id = " + @thiscompany.id.to_s ##debug
        y session #debug
  end

  def forgot
    if request.post?
    company = Company.find_by_email(params[:email])
      if company
        recipient = params[:email]
        subject 	= "Password Reminder"
        from 		= "PMT Admin <noreply@professionalmovertraining.com>"
        message 	= "Your password is \"" + company.plainpwd + "\"."
        FeedbackMailer.deliver_contact(recipient, subject, message, from)
        return if request.xhr?

	flash[:notice] = "Your password has been emailed to you"
      else
        flash[:error] = "No record matches this email address"
      end
      redirect_to(:action => "login")
    end
  end
end
