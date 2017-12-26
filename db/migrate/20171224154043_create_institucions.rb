class CreateInstitucions < ActiveRecord::Migration[5.0]
  def change
    create_table :institucions do |t|
      t.string :name
      t.integer :municipio_id

      t.timestamps
    end
  end
end
