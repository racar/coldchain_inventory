class AddItemidToMantenimiento < ActiveRecord::Migration[5.0]
  def change
    add_column :mantenimientos, :item_id, :integer
  end
end
