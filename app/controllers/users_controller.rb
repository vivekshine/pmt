class UsersController < ApplicationController
  before_filter :authorize, :except => [:login,:signup,:grantaccess,:chargecredit,:record_results,:feedback]

#  include ActiveMerchant::Billing::Integrations
#  require 'crypto42'
#  require 'money'



  # GET /users
  # GET /users.xml
  def index
    @users = User.find(:all, :conditions => ["company = ?", session[:company].id])
        p 'users index'; y session #debug
    @thiscompany = Company.find(session[:company_id])
    puts "\n\n\n @thiscompany.id = " + @thiscompany.id.to_s ##debug
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
#    puts "\n\n\n DEBUG: @thiscompany.id = " + @thiscompany.id.to_s ##debug
    @user = User.find(params[:id])
        y session #debug

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new
    @user.credits = 0  ## Stop form from complaining that "credits" is not a number.
    @thiscompany = session[:company]
    puts "\n\n\n @thiscompany.id = " + @thiscompany.id.to_s ##debug
        y session #debug
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
        y session #debug
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])
    @thiscompany = Company.find(session[:company_id])
    puts "\n\n\n @thiscompany.id = " + @thiscompany.id.to_s ##debug
        y session #debug

    respond_to do |format|
      if @user.save
        flash[:notice] = 'User was successfully created.'
        format.html { redirect_to(@user) }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end	

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])
#    puts "\n\n\n @thiscompany.id = " + @thiscompany.id.to_s ##debug
        y session #debug

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'User was successfully updated.'
        format.html { redirect_to(@user) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end

  def assigncredits
    @thiscompany = Company.find_by_id(session[:company].id)
    #@thiscompany = session[:company]
    @user = User.find(params[:id])
  end

  def movecredits
    @thiscompany = Company.find_by_id(session[:company].id)
    @user = User.find(params[:id])
    @user.credits += +5
    if @thiscompany.credits >= 5
      @thiscompany.credits += -5
      @thiscompany.save
      @user.save
    else 
      flash[:error] = 'Not enough credits to complete transaction.'
    end
  end

# These methods are to be called via RubyAMF only (params[0][:whatever])
  def chargecredit
    @user = User.find_by_username(params[0][:username])
    user=User.authenticate(params[0][:username],params[0][:password])
    if user
	# make sure we charge at least 1 credit 
	if params[0][:module_cost] < 1 
	  params[0][:module_cost] = 1
	end
        @user.credits -= params[0][:module_cost]
        if @user.save
          render :amf => {  :id => 	@user.id,
			:firstname => 	@user.firstname, 
			:lastname => 	@user.lastname, 
			:credits => 	@user.credits, 
			:company => 	@user.company
		}
	  @userhistory=UserHistory.new
	  @userhistory.userid			=user.id
	  @userhistory.module			=params[0][:module]
	  @userhistory.credits_spent		=params[0][:module_cost]
	  @userhistory.credits_remaining	=@user.credits
	  @userhistory.save	
        else
	  render :amf => "Not enough credits to complete transaction"
	end
    else
      render :amf => "Login Failed"
    end
  end

  def grantaccess
    @user = User.find_by_username(params[0][:username])
    if request.post?
     user=User.authenticate(params[0][:username],params[0][:password])
     if user
        render :amf => {:id => 		@user.id, 
			:firstname => 	@user.firstname, 
			:lastname => 	@user.lastname, 
			:credits => 	@user.credits,
			:company => 	@user.company
			}
      else
        render :amf => "Login Failed"
      end
    end
  end
  def record_results
    @user = User.find_by_username(params[0][:username])
    if request.post?
      user=User.authenticate(params[0][:username],params[0][:password])
      if user
        counter = 0
        while counter < params[0][:quizzes]
          @result = QuizResult.new
	  @result.userid = @user.id
	  @result.module = params[0][:module]
	  @result.quiz = counter
	  @result.score = params[0][:score][counter]
	  @result.runtime = params[0][:runtime]		
	  @result.save
	  counter += 1
        end
	
      render :amf => {:id => 		@user.id, 
			:firstname => 	@user.firstname, 
			:lastname => 	@user.lastname, 
			:credits => 	@user.credits,
			:company => 	@user.company,
			:counter => 	counter
			}
      else
        render :amf => "Login Failed"
      end
    end
  end

  def history
    @user = User.find(params[:id])
    @histories = UserHistory.find(:all, :conditions => ["userid = ?", params[:id]])
    @quiz_results = QuizResult.find(:all, :conditions => ["userid = ?", params[:id]])
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end


  def feedback
      recipient = "pmtdmoveu@gmail.com"
      subject 	= "Request from Website"
      from 	= params[0][:name] + " <" + params[0][:email] + ">"
      message 	= params[0][:description]
      FeedbackMailer.deliver_contact(recipient, subject, message, from)
      return if request.xhr?
      render :amf => 'Message sent successfully'
   end
end
