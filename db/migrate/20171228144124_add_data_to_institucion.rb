class AddDataToInstitucion < ActiveRecord::Migration[5.0]
  def change
    add_column :institucions, :caracter, :string
    add_column :institucions, :direccion, :string
    add_column :institucions, :nit, :string
    add_column :institucions, :cod_habilitacion, :string
    add_column :institucions, :temperatura, :string
  end
end
