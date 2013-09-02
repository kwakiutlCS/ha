$(function() {
    $(".date_selector").datepicker({ dateFormat: "MM d, yy" });
    $("#tabs").tabs();
    $(".table_row").on("click", function() {
	 $(this).children().last().slideToggle();
    });
    $(".table_row").on("mouseleave", function() {
	 $(this).children().last().slideUp();
    });

});