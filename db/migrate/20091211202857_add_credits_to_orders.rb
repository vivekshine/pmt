class AddCreditsToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :credits, :integer
  end

  def self.down
    remove_column :orders, :credits
  end
end
