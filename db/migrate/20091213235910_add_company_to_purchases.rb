class AddCompanyToPurchases < ActiveRecord::Migration
  def self.up
    add_column :purchases, :company, :integer
  end

  def self.down
    remove_column :purchases, :company
  end
end
