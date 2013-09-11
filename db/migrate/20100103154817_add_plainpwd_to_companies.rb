class AddPlainpwdToCompanies < ActiveRecord::Migration
  def self.up
    add_column :companies, :plainpwd, :string
  end

  def self.down
    remove_column :companies, :plainpwd
  end
end
