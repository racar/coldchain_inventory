class AddManToItem < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :tiene_mantenimiento, :string
  end
end
