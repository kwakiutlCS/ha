class TrendReportsController < ApplicationController
  before_filter :authenticate_user!

  def index
    load_session(params)
    if session[:period] != params[:period] || session[:trendStartDate] != params[:trendStartDate] || session[:trendEndDate] != params[:trendEndDate] || session[:category] != params[:category] 
      redirect_to trend_reports_path({period: session[:period], trendStartDate: session[:trendStartDate], trendEndDate: session[:trendEndDate], category: session[:category]})
    end

    @report = TrendReport.getReport(current_user, session)
    if @report
      tickCounter = @report.x_data.count
      @ticks = []
      counter = 1
      date_format = {"year" => '%Y', "month" => '%b, %Y', "week" => '%x', "day" => '%b %e' }
      tickCounter.times do
        @ticks << [counter, "#{@report.x_data[counter-1].strftime(date_format[@report.period])}"]
        counter += 1
      end
    else
      render :no_report
    end
  end



  private 
  def load_session(p)
    session[:period] = p[:period] if p[:period] 
    session[:trendStartDate] = p[:trendStartDate] == "" ? nil : p[:trendStartDate] 
    session[:trendEndDate] = p[:trendEndDate] == "" ? nil : p[:trendEndDate] 
    session[:category] = p[:category] if p[:category]
  end
end
