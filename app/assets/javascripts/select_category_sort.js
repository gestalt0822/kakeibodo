// $(document).ready(function(){
// 	$("#show_btn").on("click",function(){
// 		$("#hide_area").show();
// 	});
// 	$("#hide_btn").on("mouseover",function(){
// 		$("#hide_area").hide();
// 	});
// });

// $(document).ready(function(){
// 	$("#show_btn").hover(
// 		function(){	//マウスを乗せた
// 			$("#hide_area").show();
// 		},
// 		function(){	//マウスを外した
// 			$("#hide_area").hide();
// 		}
// 	);
// });


$(document).ready(function(){
	$("#show_btn").on("click",function(){
		$("#hide_area").slideToggle();
	});
  $("#close").click(function(){
    $("#hide_area").hide();
  });

});
