class AddCreditsToPurchases < ActiveRecord::Migration
  def self.up
    add_column :purchases, :credits, :integer
  end

  def self.down
    remove_column :purchases, :credits
  end
end
