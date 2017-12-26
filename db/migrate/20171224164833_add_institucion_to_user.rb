class AddInstitucionToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :institucion_id, :integer
  end
end
