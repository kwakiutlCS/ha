class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :title
      t.integer :user_id
      t.boolean :transaction_type

      t.timestamps
    end
  end
end
