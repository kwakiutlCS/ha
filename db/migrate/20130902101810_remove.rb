class Remove < ActiveRecord::Migration
  def up
    remove_column :categories, :user_id
  end

  def down
  end
end
