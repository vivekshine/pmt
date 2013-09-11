class CompaniesController < ApplicationController
  layout "moveu"
  before_filter :authorize, :except => [:new,:create]
  helper :all # include all helpers, all the time

  # GET /companies
  # GET /companies.xml
  def index
    @companies = Company.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @companies }
    end
  end

  # GET /companies/1
  # GET /companies/1.xml
   def show
    @company = Company.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @company }
    end
  end

  def justin
	@company = Company.find(params[:id])
	
  end

  # GET /companies/new
  # GET /companies/new.xml
  def new
    @company = Company.new
    @page_title= "New Company Signup"	
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @company }
    end
  end

  def edit
    @company = Company.find(params[:id])
  end

  def create
    @company = Company.new(params[:company])
    respond_to do |format|
      @company.credits=0
      @company.active=0
      @company.adminlogin = @company.email
      if @company.save
        flash[:notice] = "Company \"#{@company.name}\" was successfully created."
        format.html { redirect_to(:controller => "purchase", :action => "new", :params => {:company_id => @company.id } ) }
        format.xml  { render :xml => @company, :status => :created, :location => @company }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @company.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @company = Company.find(params[:id])
    respond_to do |format|
      if @company.update_attributes(params[:company])
        flash[:notice] = 'Company was successfully updated.'
        format.html { redirect_to(@company) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @company.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @company = Company.find(params[:id])
    @company.destroy

    respond_to do |format|
      format.html { redirect_to(companies_url) }
      format.xml  { head :ok }
    end
  end




protected
	def authorize
		@company = Company.find_by_id(session[:company_id])
		unless @company.active?
			flash[:notice] = "Please log in"
			redirect_to :controller => 'admin', :action => 'login'
  		end
	end
end
