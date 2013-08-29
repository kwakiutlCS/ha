class AddDefaultToValueCents < ActiveRecord::Migration
  def change
    change_column :transactions, :value_cents, :integer, default: 0
  end
end
