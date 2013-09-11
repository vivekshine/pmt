class AddCouponToPurchase < ActiveRecord::Migration
  def self.up
    add_column :purchases, :coupon, :integer
  end

  def self.down
    remove_column :purchases, :coupon
  end
end
