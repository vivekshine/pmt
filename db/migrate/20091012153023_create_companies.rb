class CreateCompanies < ActiveRecord::Migration
  def self.up
    create_table :companies do |t|
      t.string :name
      t.string :adminlastname
      t.string :adminfirstname
      t.string :adminlogin
      t.string :email
      t.string :company
      t.string :hashed_password
      t.string :salt

      t.timestamps
    end
  end

  def self.down
    drop_table :companies
  end
end
