
$(document).ready(function() {
	$("#open").on("click", function(event) {
		event.preventDefault();
		$(".check").slideToggle(1, function() {
		});
	});	
});

		
$(document).ready(function() {
	$("#open").on("click", function(event) {
		event.preventDefault();
		$(".tag-form").slideToggle("slow", function() {
			if($(this).is(":visible")) {
				$("#open").html("Close");
			} else {
				$("#open").html("Add Comment");
			}
		});
	});	
});