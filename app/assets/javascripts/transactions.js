$(function() {
	      
    
    // DATEPICKER
    $(".date_selector").datepicker({ dateFormat: "MM dd, yy" });
    $("#start_date_expense").datepicker({ dateFormat: "MM dd, yy" });
    $("#end_date_expense").datepicker({ dateFormat: "MM dd, yy" });

    // TABS
    $("#tabs").tabs();
    
    // TABLE
    $(".table_row_header").on("click", function() {
	 var x = $(this).parent().children().last();
	 $(".table_row_description").not(x).hide();
	 x.toggle();
    });
    $(".table_row").on("mouseleave", function() {
	 $(this).children().last().slideUp();
    });
   
    // CATEGORY MENU  
    var menu = $('.menu');
    menu.menu();

    var blurTimer;
    var blurTimeAbandoned = 0;  

    menu.on('menufocus', function() {
        clearTimeout(blurTimer);
    });

    menu.on('menublur', function(event) {
        blurTimer = setTimeout(function() {
            menu.menu("collapseAll", null, true );
        }, blurTimeAbandoned);
    });
    $("ul#expenses_category_menu.menu").on("click", "li ul li a", function() {
	 $("ul#expenses_category_menu.menu li span").text($(this).text());
	 $("#transaction_category_expenses").val($(this).text());
    });
    

    $("ul#filter_expenses_category_menu.menu").on("click", "li ul li a", function() {
	 $("ul#filter_expenses_category_menu.menu li span").text($(this).text());
	 $("#filter_category").val($(this).text());
	 $("#filter_form").submit();
    });

    $("#expense_edit_form").on("click","a#edit_expense_form_closer", function(){
    	$("#expense_edit_form").hide();
    });

    // FORM
    $("#expenses_handle").on("click", function(){
	 //$(this).hide();
	 $("#table_expenses_form").animate({left: "57%"},1000);
    });
    $(".table_form").on("click", "#expense_form_closer", function(){
	 $("#table_expenses_form").animate({left: "101%"},1000, function() {
	     //$(".table_form_handle").show();
	 });
	 
    });

    $("#category_handle").on("click", function(){
	 //$(this).hide();
	 $("#expense_category_form").animate({left: "57%"},1000);
    });
    $("#expense_category_form").on("click", "a", function(){
	 $("#expense_category_form").animate({left: "101%"},1000, function() {
	     //$(".table_form_handle").show();
	 });
	 
    });

    // FILTER
    $("#date_expense_select_fields").change(function(){
	 if ($(this).val() == "custom") {
	     $("#custom_date_expense_fields").show();
	 }
	 else {
	     $("#custom_date_expense_fields").hide();	
	     $("#filter_form").submit();
	 }
    });
    $("#start_date_expense").change(function(){
	 $("#filter_form").submit();
    });
    $("#end_date_expense").change(function(){
	 $("#filter_form").submit();
    });
   

    
});