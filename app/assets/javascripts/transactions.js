$(function() {

    // DATEPICKER
    $(".date_selector").datepicker({ dateFormat: "MM d, yy" });
    
    // TABS
    $("#tabs").tabs();
    
    // TABLE
    $(".table_row_header").on("click", function() {
	 $(".table_row_description").hide();
	 $(this).parent().children().last().slideToggle();
    });
    $(".table_row").on("mouseleave", function() {
	 $(this).children().last().delay(300).slideUp();
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

    //CATEGORY FORM
    $("#add_expense_category").on("click", function() {
	 $("#expense_category_form").toggle();
    });
    $("#expense_category_form a").on("click", function() {
	  $("#expense_category_form").hide();
    });
});