class AddFechmanToMantenimiento < ActiveRecord::Migration[5.0]
  def change
    add_column :mantenimientos, :fecha_man1, :date
    add_column :mantenimientos, :fecha_man2, :date
    add_column :mantenimientos, :fecha_man3, :date
    add_column :mantenimientos, :fecha_man4, :date
    add_column :mantenimientos, :fecha_man5, :date
    add_column :mantenimientos, :fecha_man6, :date
    add_column :mantenimientos, :fecha_man7, :date
    add_column :mantenimientos, :fecha_man8, :date
    add_column :mantenimientos, :fecha_man9, :date
    add_column :mantenimientos, :fecha_man10, :date
    add_column :mantenimientos, :fecha_man11, :date
    add_column :mantenimientos, :fecha_man12, :date
  end
end
