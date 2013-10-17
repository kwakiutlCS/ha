$(function() {

    $("#trendPlotFilter").on("change", "#trendPlotPeriodField", function() {
	$("#trend_plot_form").submit();
    });
    
    $("#trendPlotFilter").on("change", "#trendPlotEndDateField", function() {
	$("#trend_plot_form").submit();
    });
    $("#trendPlotFilter").on("change", "#trendPlotStartDateField", function() {
	$("#trend_plot_form").submit();
    });

    $("ul#trendPlotCategoryMenu").on("click", "li ul li a", function() {
	$("ul#trendPlotCategoryMenu.menu li span").text($(this).text());
	 $("#trendPlotCategoryField").val($(this).text());
	 $("#trend_plot_form").submit();
    });
    
});