$(document).on("click","#newElectiveTypeBtnID",function(){
	jQuery.ajax({
		url:"mg_elective_types/new",
		success:function(html){
			$("#newElectiveTypeDialogID").dialog({
				title:"New Elective Type",
				modal: true,
				open:function(){
					$(this).html(html);
				}
			});
		}
	});
});

$(document).on("click",".editElectiveType",function(){

	var my_id = $(this).attr("id");
	var elective_type_id = my_id.split("-");

	jQuery.ajax({
		url: "mg_elective_types/"+elective_type_id[1]+"/edit",
		success: function(html){
			$("#editElectiveTypeDialogID").dialog({
				title:"Edit Elective Type",
				modal: true,
				open:function(){
					$(this).html(html);
				}
			});
		}
	});
});

$(document).on("click",".showElectiveType",function(){
	var my_id = $(this).attr("id");
	var elective_type_id = my_id.split("-");

	jQuery.ajax({
		url: "mg_elective_types/"+elective_type_id[1],
		success: function(html){
			$("#showElectiveTypeDialogID").dialog({
        maxHeight:"auto",
				width:"auto",

				title:"Show Elective Type",
				modal: true,
				open:function(){
					$(this).html(html);
				}
			});
		}
	});
});

$(document).on("click", ".deleteElectiveType", function(e){
    var myID =$(this).attr('id');
    var elective_type_id=myID.split('-');
    var retVal = confirm("Are you sure to delete?");
    if(retVal){
      //  alert(retVal);
         var urlLink = "mg_elective_types/delete/"+elective_type_id[1];

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