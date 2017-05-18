$(document).on("change",".round_data",function(){

   	var data=$(".round_data").size();
   	var demo=$(this);
   
   for(var i=1;i<=data;i++){

   if(demo.attr('id')=="round_"+i){
	}
	else{
		if($(this).val()==$("#round_"+i).val()){
		   alert("This option is already selected please select different Option")
		   $(this).prop("selectedIndex", 0);
    }
    else{

    }
}

		}
  });



$(document).on("change","#placements_registration_status",function(){
  var status_val=$("#placements_registration_status").val();
  if(status_val=="Inactive"){
    var result=confirm("Are you sure to Inactive?");
    if(result){
      $(".show-reson-label-cls").show();
      $(".show-reson-text-area-cls").show();
    }
  }else{
    $(".show-reson-label-cls").hide();
    $(".show-reson-text-area-cls").hide();
  }
});

