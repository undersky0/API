class UpdateOrder < ActiveRecord::Migration
  def change
    remove_column :orders, :vat
    add_column :orders, :vat, :decimal, precision: 8, scale: 2, default: 20.0
  end
end
