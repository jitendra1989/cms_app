$(document).on("click","#newElectiveGroupBtnID",function(){
	jQuery.ajax({
		url:"mg_elective_groups/new",
		 cache: false,
		success:function(html){
			$("#newElectiveGroupDialogID").dialog({
				title:"New Elective Group",
				modal: true,
				open:function(){
					$(this).html(html);
				}
			});
		}
	});
});

$(document).on("click",".editElectiveGroup",function(){

	var my_id = $(this).attr("id");
	var elective_group_id = my_id.split("-");

	jQuery.ajax({
		url: "mg_elective_groups/"+elective_group_id[1]+"/edit",
		 cache: false,
		success: function(html){
			$("#editElectiveGroupDialogID").dialog({
				modal: true,
				title:"Edit Elective Group",
				open:function(){
					$(this).html(html);
				}
			});
		}
	});
});

$(document).on("click",".showElectiveGroup",function(){
	var my_id = $(this).attr("id");
	var elective_group_id = my_id.split("-");

	jQuery.ajax({
		url: "mg_elective_groups/"+elective_group_id[1],
		 cache: false,
		success: function(html){
			$("#showElectiveGroupDialogID").dialog({
        maxheight:"auto",
				width:"auto",
				modal: true,
				title:"Show Elective Group",
				open:function(){
					$(this).html(html);
				}
			});
		}
	});
});

$(document).on("click", ".deleteElectiveGroup", function(e){
    var myID =$(this).attr('id');
    var elective_group_id=myID.split('-');
    var retVal = confirm("Are you sure to delete?");
    if(retVal){
      //  alert(retVal);
         var urlLink = "mg_elective_groups/destroy/"+elective_group_id[1];


          $.ajax({
            url: urlLink ,
            cache: false,
          
            success: function(html){
               window.location.reload();
                           
            }
        });

    }else{
       // alert(retVal);     
       return false;
    }

}); 
