class CreateMantenimientos < ActiveRecord::Migration[5.0]
  def change
    create_table :mantenimientos do |t|
      t.integer :man_programados
      t.integer :man_realizados
      t.string :observaciones
      t.date :fecha_firma
      t.date :fecha_vigencia
      t.string :supervisor
      t.string :cargo_supervisor

      t.timestamps
    end
  end
end
