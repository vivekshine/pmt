class AddCreditsToCompanies < ActiveRecord::Migration
  def self.up
    add_column :companies, :credits, :integer
  end

  def self.down
    remove_column :companies, :credits
  end
end
