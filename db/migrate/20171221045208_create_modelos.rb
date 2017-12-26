class CreateModelos < ActiveRecord::Migration[5.0]
  def change
    create_table :modelos do |t|
      t.string :nombre
      t.integer :marca_id

      t.timestamps
    end
  end
end
