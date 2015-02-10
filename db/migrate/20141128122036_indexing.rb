class Indexing < ActiveRecord::Migration
  def change
		add_index :products, :item_line_id
		add_index :orders, :user_id
		add_index :item_lines, :order_id
		add_index :status_transitions, :order_id
  end
end
