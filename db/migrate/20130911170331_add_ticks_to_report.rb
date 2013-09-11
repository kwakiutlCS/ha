class AddTicksToReport < ActiveRecord::Migration
  def change
    add_column :trend_reports, :ticks, :text
  end
end
