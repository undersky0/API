class CreateV1ItemLines < ActiveRecord::Migration
  def change
    create_table :item_lines do |t|
      t.integer :quantity, :default => 0
      t.decimal :net_price
      t.integer :order_id

      t.timestamps
    end
  end
end
