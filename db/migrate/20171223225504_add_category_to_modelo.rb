class AddCategoryToModelo < ActiveRecord::Migration[5.0]
  def change
    add_column :modelos, :category_id, :integer
  end
end
