class TrendReport < ActiveRecord::Base
  attr_accessible :title, :x_data, :x_label, :y_data, :y_label, :period, :ticks

  validates :title, presence: true
  validates :y_label, presence: true
  validates :x_label, presence: true
  validates :y_data, presence: true
  validates :x_data, presence: true
  
  serialize :x_data
  serialize :y_data
  serialize :ticks



  def self.getReport(user, options = {})
    return false if user.transactions.empty?
    
    if options[:trendStartDate]
      startDate = Date.parse(options[:trendStartDate])
    else
      firstRecordDate = user.transactions.where(transaction_type: false).order("date").first.date 
      if options[:period] == "year"
        startDate = firstRecordDate
      elsif firstRecordDate < Date.today-1.year
        startDate = Date.today-1.year
      elsif firstRecordDate < (Date.today-2.months).beginning_of_month
        startDate = firstRecordDate.beginning_of_month
      else
        startDate = firstRecordDate.beginning_of_week
        
      end
    end
   
    endDate = options[:trendEndDate] || Date.today.to_s
    endDate = Date.parse(endDate)
    
    period = options[:period] || (startDate < (Date.today-2.months).beginning_of_month ? "month" : "week")
    
    category = options[:category] || "All"
    
    if category == "All" 
      data = user.transactions.where("date >= ? and date <= ? and transaction_type = ?", startDate, endDate, false).group_by {|i| i.date.send("beginning_of_#{period}")}
      
    elsif category == "No Category"
      data = user.transactions.where("date >= ? and date <= ? and category_id is NULL and transaction_type = ?", startDate, endDate, false).group_by {|i| i.date.send("beginning_of_#{period}")}
      
    else
      category_id = user.categories.where(title: category.downcase).first
      data = user.transactions.where("date >= ? and date <= ? and category_id = ? and transaction_type = ?", startDate, endDate, category_id, false).group_by {|i| i.date.send("beginning_of_#{period}")}
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

    report.period = period
    report.ticks = []

    tickCounter = report.x_data.count 
    ticksStep = tickCounter/10+1
    date_format = {"year" => '%Y', "month" => '%b, %Y', "week" => '%b %e', "day" => '%b %e' }
    counter = 0
    tickCounter.times do
      if (counter)%ticksStep == 0
        report.ticks << [counter+1, "#{report.x_data[counter].strftime(date_format[period])}"]
      end
      counter += 1
    end

    report.y_label = "$"
    report.title = "Total Expenses per #{period.capitalize}"
    
    [report, startDate]
  end


 
end
