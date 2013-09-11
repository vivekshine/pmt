class Order < ActiveRecord::Base
  has_many :transactions,
	   :class_name => 'OrderTransaction',
	   :dependent => :destroy

  acts_as_state_machine :initial => :pending
attr_accessor :ip_address
  state :pending
  state :authorized
  state :payment_declined
  state :purchasing

  event :purchase_transacpayment_declinedtion do
    transitions :from 	=> :pending,
		:to	=> :purchasing
  end

  event :payment_authorized do
    transitions :from 	=> :pending,
		:to	=> :authorized

    transitions :from	=> :payment_declined,
		:to	=> :authorized
  end

  event :payment_captured do
    transitions :from 	=> :purchasing,
		:to	=> :paid
  end

  event :transaction_declined do
    transitions :from	=> :purchasing,
		:to	=> :purchasing
  end


def purchase
  response = process_purchase
  if response.success?
    payment_captured!
    transactions.create!(:action => "purchase", :amount => 37500, :response => response,:success=>true)
  else
    transaction_declined!
  end  
  response.success?
end

def express_token=(token)
  write_attribute(:express_token, token)
  if new_record? && !token.blank?
    details = EXPRESS_GATEWAY.details_for(token)
    self.express_payer_id = details.payer_id
  end
end

private

def process_purchase
  if express_token.blank?
    STANDARD_GATEWAY.purchase(37500, credit_card, standard_purchase_options)
  else
    EXPRESS_GATEWAY.purchase(37500, express_purchase_options)
  end
end

def standard_purchase_options
  # {
  #   :ip => ip_address,
  #   :billing_address => {
  #     :name     => "Ryan Bmmkdmdmdates",
  #     :address1 => "123 Main St.",
  #     :city     => "New York",
  #     :state    => "NY",
  #     :country  => "US",
  #     :zip      => "10001"
  #   }
  # }
end

def express_purchase_options
  {
    :ip => ip_address,
    :token => express_token,
    :payer_id => express_payer_id
  }
end

def validate_card
  if express_token.blank? && !credit_card.valid?
    credit_card.errors.full_messages.each do |message|
      errors.add_to_base message
    end
  end
end



 #  def make_purchase(credit_card, options = {})
 #    transaction do
 #      result = OrderTransaction.purchase(amount, credit_card, options)
 #      transactions.push(result)
 #      if result.success?
 #        purchase_transaction!
	# payment_captured!
 #      else
	# transaction_declined!
 #      end
 #      result
 #    end
 #  end


 #  def authorize_payment(credit_card, options = {})
 #    options[:order_id] = number

 #    transaction do
 #      authorization = Order.Transaction.authorize(amount, credit_card, options)
 #      transactions.push(authorization)

 #      if authorization.success?
 #        payment_authorized!
 #      else
 #        transaction_declined!
 #      end

 #      authorization
 #    end
 #  end

  def number
    "#{Time.now.to_i}-#{rand(1_000_000)}"
  end

  # def authorization_reference
  #   if authorization = transactions.find_by_action_and_success('authorization', true, :order => 'id ASC')
  #     authorization.reference
  #   end
  # end

  # def capture_payment(options = {})
  #   transaction do
  #     capture = OrderTransaction.capture(amount, authorization_reference, options)
  #     transaction.push(capture)
  #     if capture.success?
  #       payment_captured!
  #     else
  #       transaction_declined!
  #     end
  #     capture
  #   end
  # end

end
