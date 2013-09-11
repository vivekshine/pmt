class AddCouponToCompanies < ActiveRecord::Migration
  def self.up
    add_column :companies, :coupon, :string
  end

  def self.down
    remove_column :companies, :coupon
  end
end
