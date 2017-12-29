class AddRefrigeracionToItem < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :capacidad_refrigeracion, :string
  end
end
