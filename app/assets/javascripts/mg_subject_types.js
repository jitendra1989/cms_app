$(document).on("click","#newSubjectTypeBtnID",function(){
	jQuery.ajax({
		url:"mg_subject_types/new",
		success:function(html){
			$("#newSubjectTypeDialogID").dialog({
				title:"New Subject Type",
				modal: true,
				open:function(){
					$(this).html(html);
				}
			});
		}
	});
});

$(document).on("click",".editSubjectType",function(){

	var my_id = $(this).attr("id");
	var subject_type_id = my_id.split("-");

	jQuery.ajax({
		url: "mg_subject_types/"+subject_type_id[1]+"/edit",
		success: function(html){
			$("#editSubjectTypeDialogID").dialog({
				title:"Edit Subject Type",
				modal: true,
				open:function(){
					$(this).html(html);
				}
			});
		}
	});
});

$(document).on("click",".showSubjectType",function(){

	var my_id = $(this).attr("id");
	var subject_type_id = my_id.split("-");
	jQuery.ajax({
		url: "mg_subject_types/"+subject_type_id[1],
		success: function(html){
			$("#showSubjectTypeDialogID").dialog({
				minHeight: "auto",
				width: "auto",
				title:"Show Subject Type",
				modal: true,
				open:function(){
					$(this).html(html);
				}
			});
		}
	});
});