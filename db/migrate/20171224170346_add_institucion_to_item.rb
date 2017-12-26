class AddInstitucionToItem < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :institucion_id, :integer
  end
end
