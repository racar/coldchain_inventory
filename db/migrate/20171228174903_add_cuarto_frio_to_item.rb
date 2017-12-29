class AddCuartoFrioToItem < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :dimensiones, :string
    add_column :items, :funciona, :string
    add_column :items, :compresor, :string
    add_column :items, :num_compresores, :string
  end
end
