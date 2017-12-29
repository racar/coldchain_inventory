class AddTipoToItem < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :tipo, :string
  end
end
