class TrendReportsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @report = TrendReport.getReport(current_user)
    tickCounter = @report.x_data.count
    @ticks = []
    counter = 1
    tickCounter.times do
      @ticks << [counter, "#{@report.x_data[counter-1].strftime('%b, %Y')}"]
      counter += 1
    end
  end

end
