class AddMarcaModeloDigitadosToItem < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :marca_digitada, :string
    add_column :items, :modelo_digitado, :string
  end
end
