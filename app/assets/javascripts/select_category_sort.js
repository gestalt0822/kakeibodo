// $(document).ready(function(){
// 	$("#show_btn").on("click",function(){
// 		$("#hide_area").show();
// 	});
// 	$("#hide_btn").on("mouseover",function(){
// 		$("#hide_area").hide();
// 	});
// });

// $(document).ready(function(){
// 	$("#show_btn").click(
// 		console.log("あああ");
// 		function(){
// 			$("#hide_area").show();
// 		};
//
// 		$("#close").click(
// 			function(){
// 				$("#hide_area").hide();
// 			};
// });

		// console.log("ああああああ");

//
$(document).ready(function(){
	$("#show_btn").on("click",function(){
		$("#hide_area").slideToggle();
		});
  $("#close").click(function(){
    $("#hide_area").hide();
  });

		$("#show_btn2").on("click",function(){
			$("#hide_area2").slideToggle();
			});
	  $("#close2").click(function(){
	    $("#hide_area2").hide();
	  });

});
