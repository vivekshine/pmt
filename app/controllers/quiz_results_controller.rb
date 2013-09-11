class QuizResultsController < ApplicationController
  # GET /quiz_results
  # GET /quiz_results.xml
  def index
    @quiz_results = QuizResult.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @quiz_results }
    end
  end

  # GET /quiz_results/1
  # GET /quiz_results/1.xml
  def show
    @quiz_result = QuizResult.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @quiz_result }
    end
  end

  # GET /quiz_results/new
  # GET /quiz_results/new.xml
  def new
    @quiz_result = QuizResult.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @quiz_result }
    end
  end

  # GET /quiz_results/1/edit
  def edit
    @quiz_result = QuizResult.find(params[:id])
  end

  # POST /quiz_results
  # POST /quiz_results.xml
  def create
    @quiz_result = QuizResult.new(params[:quiz_result])

    respond_to do |format|
      if @quiz_result.save
        flash[:notice] = 'QuizResult was successfully created.'
        format.html { redirect_to(@quiz_result) }
        format.xml  { render :xml => @quiz_result, :status => :created, :location => @quiz_result }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @quiz_result.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /quiz_results/1
  # PUT /quiz_results/1.xml
  def update
    @quiz_result = QuizResult.find(params[:id])

    respond_to do |format|
      if @quiz_result.update_attributes(params[:quiz_result])
        flash[:notice] = 'QuizResult was successfully updated.'
        format.html { redirect_to(@quiz_result) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @quiz_result.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /quiz_results/1
  # DELETE /quiz_results/1.xml
  def destroy
    @quiz_result = QuizResult.find(params[:id])
    @quiz_result.destroy

    respond_to do |format|
      format.html { redirect_to(quiz_results_url) }
      format.xml  { head :ok }
    end
  end
end
