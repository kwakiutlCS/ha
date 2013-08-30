class AddTransactionTypeToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :transaction_type, :boolean, default: false
  end
end
