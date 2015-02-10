class AddItemLineForeignKeyToProduct < ActiveRecord::Migration
  def change
    remove_column :products, :item_line_id
    add_column :products, :item_line_id, :integer
  end
end
