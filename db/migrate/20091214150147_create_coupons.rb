class CreateCoupons < ActiveRecord::Migration
  def self.up
    create_table :coupons do |t|
      t.string :code
      t.string :value
      t.boolean :active

      t.timestamps
    end
  end

  def self.down
    drop_table :coupons
  end
end
