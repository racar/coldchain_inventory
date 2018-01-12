class AddCatToItem < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :category_id, :integer
    add_column :items, :marca_id, :integer
    add_column :items, :modelo_id, :integer
  end
end
