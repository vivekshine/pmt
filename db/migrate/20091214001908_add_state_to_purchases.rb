class AddStateToPurchases < ActiveRecord::Migration
  def self.up
    add_column :purchases, :state, :string
  end

  def self.down
    remove_column :purchases, :state
  end
end
