class CreateTrendReports < ActiveRecord::Migration
  def change
    create_table :trend_reports do |t|
      t.text :x_data
      t.text :y_data
      t.string :x_label
      t.string :y_label
      t.string :title

      t.timestamps
    end
  end
end
