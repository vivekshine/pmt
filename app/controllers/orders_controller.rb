class OrdersController < ApplicationController
  include ActiveMerchant::Billing   
  include ActiveMerchant::Billing::Integrations
  # GET /orders
  # GET /orders.xml
  def index
    @orders = Order.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.xml
  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.xml
  # def new
  #   @order = Order.new
  #   @credit_card = CreditCard.new
  #   respond_to do |format|
  #     format.html # new.html.erb
  #     format.xml  { render :xml => @order }
  #   end
  # end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
  end

  # POST /orders
  # POST /orders.xml
  def create
    @order = Order.new(params[:order])
    @order.ip_address = request.remote_ip
    if @order.save
      if @order.purchase
        redirect_to @order , :notice => "success"
      else
        redirect_to new_purchase_url , :notice => "try again"
      end
    else
      render :action => 'new'
    end
  end

  # PUT /orders/1
  # PUT /orders/1.xml
  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        flash[:notice] = 'Order was successfully updated.'
        format.html { redirect_to(@order) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.xml
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to(orders_url) }
      format.xml  { head :ok }
    end
  end

  def express
    response = EXPRESS_GATEWAY.setup_purchase(37500,
      :ip                => request.remote_ip,
      :return_url        => new_order_url,
      :cancel_return_url => new_order_url
    )
    redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
  end

  def new
    @order = Order.new(:express_token => params[:token])
  end
end
