class CreateV1Orders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :state
      t.decimal :vat , precision: 8, scale: 2
      t.integer :user_id
      t.timestamps :order_date
      t.timestamps
    end
  end
end
