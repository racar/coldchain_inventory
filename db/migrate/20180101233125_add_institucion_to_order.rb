class AddInstitucionToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :institucion_id, :integer
  end
end
