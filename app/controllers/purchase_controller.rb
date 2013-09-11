#require "money"
class PurchaseController < ApplicationController
  include ActiveMerchant::Billing   
  include ActiveMerchant::Billing::Integrations

  def index
  end

  def enter_coupon
  end

  def choose_subscription
    p "#{request.remote_ip.inspect}"
p 'gthyujik'
  p request.remote_ip.inspect
   p request
    @company = Company.find_by_id(params['company_id'])
    @subscription_plan_id = params["subscription_plan_id"]
    if @company.nil?
      redirect_to "/admin/login"
    end
  end

# Signup a new company, Price=Baseprice-Coupon
  def new
    company_id = params[:company_id]
    @company = Company.find_by_id(company_id)
    @subscription_plan_id = params["subscription_plan_id"]
    x_tran_key="9Pk82B77ab9nh7Nq"
    @order=Purchase.new
#   Activate for full price:
   baseprice = 375
#   Starting price - $50 :
#    baseprice = 50

    coupon=@company.coupon
    @coupon = Coupon.find_by_code(coupon)
    if @coupon
      if @coupon.active?
	couponvalue = Integer(@coupon.value)
        amount = baseprice - couponvalue
        @order.coupon = coupon
        flash[:notice] = "Coupon has been applied"
      else
        flash[:error] = "Coupon has expired"
        amount = baseprice
      end
    else
      amount = baseprice	
    end
    amount = amount.to_s() + ".00"
    @amount = amount
    @order.amount = amount
    @order.credits = 20
    @order.number = number
    @order.state = "pending"
    loginid="8Ty3NvP8z7z"
    fp = InsertFP(loginid, x_tran_key, @amount, "0001")
    @order.company = company_id
    @order.save
  end

# Purchase 20 Credits, no coupons allowed here
  def buy_20_credits
    x_tran_key="9Pk82B77ab9nh7Nq"
    @order=Purchase.new
    baseprice = 50
    amount = baseprice	
    amount = amount.to_s() + ".00"
    @amount = amount
    @order.amount = amount
    @order.credits = 20
    @order.number = number
    @order.state = "pending"
    loginid="8Ty3NvP8z7z"
    fp = InsertFP(loginid, x_tran_key, @amount, "0001")
    id = session[:company_id]
    @company = Company.find(id)
    @order.company = id
    @order.save
  end

# Purchase 5 Credits, no coupons allowed here
  def buy_5_credits
    x_tran_key="9Pk82B77ab9nh7Nq"
    @order=Purchase.new
    baseprice = 25
    amount = baseprice
    amount = amount.to_s() + ".00"
    @amount = amount
    @order.amount = amount
    @order.credits = 5
    @order.number = number
    @order.state = "pending"
    loginid="8Ty3NvP8z7z"
    fp = InsertFP(loginid, x_tran_key, @amount, "0001")
    id = session[:company_id]
    @company = Company.find(id)
    @order.company = id
    @order.save
  end

# Purchase 60 Credits, no coupons allowed here
  def buy_60_credits
    x_tran_key="9Pk82B77ab9nh7Nq"
    @order=Purchase.new
    baseprice = 75
    amount = baseprice
    amount = amount.to_s() + ".00"
    @amount = amount
    @order.amount = amount
    @order.credits = 60
    @order.number = number
    @order.state = "pending"
    loginid="8Ty3NvP8z7z"
    fp = InsertFP(loginid, x_tran_key, @amount, "0001")
    id = session[:company_id]
    @company = Company.find(id)
    @order.company = id
    @order.save
  end


  def payment_success
#   @order=Purchase.find_by_number(params[:x_invoice_num])i
    @order=Purchase.find_by_number(params['merchant_order_id'])
    product_id = params["product_id"]
    @company=Company.find_by_id(@order.company)
    if @order.state == "pending"
      @company.credits+= @order.credits
      @company.active=1
      @company.save	
      @order.state= "completed"
      @order.save
    end
  end

  def hmac(key, data)
    return OpenSSL::HMAC.hexdigest(OpenSSL::Digest::Digest.new('md5'), key, data)
  end

  def InsertFP(loginid, x_tran_key, amount, sequence, currency = "")
    tstamp = Time.now.to_i.to_s;
    fingerprint = hmac(x_tran_key, loginid + "^" + sequence + "^" + tstamp + "^" + amount + "^" + currency);
    @str = '<input type="hidden" name="x_fp_sequence" value="' + sequence + '">  <input type="hidden" name="x_fp_timestamp" value="' + tstamp + '">      <input type="hidden" name="x_fp_hash" value="' + fingerprint + '">'
    return 0;
  end
  def number
    "#{Time.now.to_i}-#{rand(1_000_000)}"
  end
end


