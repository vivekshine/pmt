class AddNumberToPurchases < ActiveRecord::Migration
  def self.up
    add_column :purchases, :number, :string
  end

  def self.down
    remove_column :purchases, :number
  end
end
