rclass TrendReportsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @report = TrendReport.getReport(current_user)
  end

end
