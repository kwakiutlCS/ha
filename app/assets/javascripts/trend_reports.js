
$.plot($("#trendPlotArea"), [
    {
     color: "orange",
     data: <%= @report.y_data %>,
     bars: {show: true, barWidth: 0.7, align: "center", fill: 0.6}, 
    }
  ],

  {
  xaxis :{
  ticks: <%= raw(@ticks) %>,
  min: 0,
  max: <%= @report.x_data.count+1 %>,
  
  },

  
  }

 
  
  );



$("#trendStartDate").val("iaj");
$("#trendEndDate").datepicker();
