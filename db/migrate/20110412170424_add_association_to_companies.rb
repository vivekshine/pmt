class AddAssociationToCompanies < ActiveRecord::Migration
  def self.up
    add_column :companies, :association, :string
  end

  def self.down
    remove_column :companies, :association
  end
end
