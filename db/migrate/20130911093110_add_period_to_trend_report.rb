class AddPeriodToTrendReport < ActiveRecord::Migration
  def change
    add_column :trend_reports, :period, :string
  end
end
