class AddPotenciaToItem < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :potencia, :string
  end
end
