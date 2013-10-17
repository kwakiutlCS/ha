$("#trendPlotCategoryMenu li span").html("<%= session[:category] || 'All' %>");
  $("#trendPlotCategoryField").html("<%= session[:category] || 'All' %>");
  $("#trendPlotPeriodField").val("<%= session[:period] || 'month' %>");
  $("#trendPlotStartDateField").val("<%= session[:trendStartDate] || (Date.today.beginning_of_month-1.year).strftime('%B %d, %Y') %>");
  $("#trendPlotEndDateField").val("<%= session[:trendEndDate] || Date.today.strftime('%B %d, %Y') %>");

  $("#trendPlotStartDateField").datepicker({ dateFormat: "MM dd, yy" });
  $("#trendPlotEndDateField").datepicker({ dateFormat: "MM dd, yy" });
  
  


  
$.plot($("#trendPlotArea"), [
    {
     color: "orange",
     data: <%= @report.y_data %>,
     bars: {show: true, barWidth: 0.7, align: "center", fill: 0.6}, 
    }
  ],

  {
  xaxis :{
  ticks: <%= raw(@report.ticks) %>,
  min: 0,
  max: <%= @report.x_data.count+1 %>,
  
  },

  
  }

  );