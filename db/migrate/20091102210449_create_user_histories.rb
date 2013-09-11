class CreateUserHistories < ActiveRecord::Migration
  def self.up
    create_table :user_histories do |t|
      t.integer :userid
      t.string :module

      t.timestamps
    end
  end

  def self.down
    drop_table :user_histories
  end
end
