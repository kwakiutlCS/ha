class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :value_cents
      t.string :currency, default: "dollar"
      t.date :date, default: Date.today
      t.integer :category_id
      t.integer :user_id
      t.string :description, default: ""

      t.timestamps
    end
  end
end
