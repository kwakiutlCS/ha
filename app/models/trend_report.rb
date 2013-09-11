class TrendReport < ActiveRecord::Base
  attr_accessible :title, :x_data, :x_label, :y_data, :y_label, :period

  validates :title, presence: true
  validates :y_label, presence: true
  validates :x_label, presence: true
  validates :y_data, presence: true
  validates :x_data, presence: true
  
  serialize :x_data
  serialize :y_data



  def self.getReport(user, options = {})
    return false if user.transactions.empty?

    if options[:trendStartDate]
      startDate = Date.parse(options[:trendStartDate])
    else
      firstRecordDate = user.transactions.where(transaction_type: false).order("date").limit(1).first.date 
      if firstRecordDate < Date.today-1.year
        startDate = Date.today-1.year
      elsif firstRecordDate < (Date.today-2.months).beginning_of_month
        startDate = firstRecordDate.beginning_of_month
      else
        startDate = firstRecordDate.beginning_of_week
      end
    end
   
    endDate = options[:trendEndDate] || Date.today

    period = options[:period] || (startDate < (Date.today-2.months).beginning_of_month ? "month" : "week")
    
    category_id = options[:category_id] || "all"
    
    
    if category_id == "all"
      data = user.transactions.where("date >= ? and date <= ?", startDate, endDate).group_by {|i| i.date.send("beginning_of_#{period}")}
    else
      data = user.transactions.where("date >= ? and date <= ? and category_id = ?", startDate, endDate, category_id).group_by {|i| i.date.send("beginning_of_#{period}")}
    end

    data.each do |k,v|
      data[k] = v.inject(0) {|sum, i| sum+i.value_cents/100.to_f}
    end
    
    report = TrendReport.new
    report.x_data = data.keys.sort
    report.y_data = []
    report.x_data.each_with_index do |i,index|
      report.y_data << [index+1,data[i].round(2)]
    end
    
    report.y_label = "$"
    report.title = "Total Expenses per #{period.capitalize}"
    report.period = period

    report
  end


 
end
