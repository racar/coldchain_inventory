class AddCategoryToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :category_id, :integer
  end
end
