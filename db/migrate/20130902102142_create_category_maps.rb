class CreateCategoryMaps < ActiveRecord::Migration
  def change
    create_table :category_maps do |t|
      t.integer :user_id
      t.integer :category_id

      t.timestamps
    end
  end
end
