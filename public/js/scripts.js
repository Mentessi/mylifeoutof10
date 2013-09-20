$(document).ready(function(){

	$("#getter").click(function(event){
    event.preventDefault();
    var tweet_results_p = $("#results")
    $.get("/tweets", function(data) {   	
	  tweet_results_p.empty();
	  tweet_results_p.append(data);
	})
  });

});


