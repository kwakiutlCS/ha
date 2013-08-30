class RemoveDefaultDateTransaction < ActiveRecord::Migration
  def up
    change_column_default :transactions, :date, nil
  end

  def down
  end
end
