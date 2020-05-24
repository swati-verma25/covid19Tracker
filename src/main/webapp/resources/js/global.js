$(document).ready(function(){
	$(".focusfield").focus();


	$(".errorf").focus();

	$(".toupper").bind('keyup', function (e) {
	    if (e.which >= 97 && e.which <= 122) {
	        var newKey = e.which - 32;
	        e.keyCode = newKey;
	        e.charCode = newKey;
	    }

	    $(this).val(($(this).val()).toUpperCase());
	});

	function allTitleCase(inStr) { return inStr.replace(/\w\S*/g, function(tStr) { return tStr.charAt(0).toUpperCase() + tStr.substr(1).toLowerCase(); }); }

	$(".firstupper").bind('keyup', function (e) {
	       $(this).val(allTitleCase($(this).val()));
	});


	$(".numericonly").keypress(function (e) {
		var node = $(this);
	    if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
	    	node.attr("placeholder","Numeric only");
	        return false;
	    }
	  });

	$(".alphaonly").keypress(function (e) {
		var node = $(this);
	    if (e.which != 32 && e.which != 8 && e.which != 0 && (e.which < 65 || e.which > 90)  && (e.which < 97 || e.which > 122)) {
	    	node.attr("placeholder","Alphabet only");
	        return false;
	    }
	  });


	$(".alphanumeric").keypress(function (e) {
		var node = $(this);
	    if (e.which != 8 && e.which != 0 && (e.which < 33 || e.which > 57) && e.which != 32 && e.which != 8 && e.which != 0 && (e.which < 65 || e.which > 90)  && (e.which < 97 || e.which > 122)) {
	    	node.attr("placeholder","Alpha Numeric only");
	        return false;
	    }
	  });



	if($(".errorf").length > 0){
		 $(".errorf:first").closest("select").focus();
		 $(".errorf:first").prev().focus();
	} else {
		 $(".focusElement").focus();
	}

	function validateEmail(email) {
	    var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
	    return re.test(email);
	}
});

