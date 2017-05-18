function elective_group_change(elective_group_id){
	var class_id=$("#mg_elective_student_association_mg_batch_id").val();
	$.ajax({
		url:"/mg_elective_student_associations/subject_list",
		data:{"mg_elective_group_id":elective_group_id,"mg_course_id":class_id},
		success: function(html){
			$("#subjectPID").html(html);
		},
		error: function(){
			alert("inside error");
		}
	});
}

function section_change(section_id){
	$("#section_id").value=section_id;
}