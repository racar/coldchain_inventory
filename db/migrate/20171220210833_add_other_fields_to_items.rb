class AddOtherFieldsToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :marca, :string
    add_column :items, :modelo, :string
    add_column :items, :serial, :string
    add_column :items, :mantenimiento, :string
    add_column :items, :num_manten_year, :string
    add_column :items, :regulador, :string
    add_column :items, :monitoreo, :string
    add_column :items, :tipo_id, :integer
    add_column :items, :volumen, :string
    add_column :items, :num_paquetes, :string
  end
end
