class AddBatInfoToItem < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :cargador_bateria, :string
    add_column :items, :transfer_automatica, :string
  end
end
