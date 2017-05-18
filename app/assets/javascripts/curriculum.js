$(document).on("click", "#checkAllCheckBoxInCurriculumId", function(e){

        $(".auto-ckeckbox-fee-particular-batch-cls").prop('checked', true);
        e.preventDefault();
        
  });

  $(document).on("click", "#unCheckAllCheckBoxInCurriculumId", function(e){

        $(".auto-ckeckbox-fee-particular-batch-cls").prop('checked', false);
        e.preventDefault();
  });

function myBatchSubjectFunction(batchid){
    var urlLink = "/curriculum/batchsubject_new/";
      
        $.ajax({
            url: urlLink ,
            data:{"mg_batch_id":batchid},
            cache: false,
            success: function(html){
                //alert("hii")
            //console.log(html);
            $("#BatchClassID").empty();
            $("#BatchClassID").append(html);
            
        }
                }); 
    };

    function myBatchSubjectsFunction(subjectid){
    var urlLink = "/curriculum/batchsubject_syllabus";
       
        $.ajax({
            url: urlLink ,
            data:{"mg_subjects_id":subjectid},
            cache: false,
            success: function(html){
               
                //alert("hii")
            //console.log(html);
            $("#SubjectID").empty();
            $("#SubjectID").append(html);
            
        }
                }); 
    };

    function mySubjectFunction(subjectid){
    var urlLink = "/curriculum/student_syllabus";
      
        $.ajax({
            url: urlLink ,
            data:{"mg_subjects_id":subjectid},
            cache: false,
            success: function(html){
               
                //alert("hii")
            //console.log(html);
            $("#TopicClassID").empty();
            $("#TopicClassID").append(html);
            
        }
                }); 
    };

    function myEmployeeSubjectFunction(employeeid){
    var urlLink = "/curriculum/employee_subject";
       
        $.ajax({
            url: urlLink ,
            data:{"mg_employee_id":employeeid},
            cache: false,
            success: function(html){
               
                //alert("hii")
            //console.log(html);
            $("#EmployeeClassID").empty();
            $("#EmployeeClassID").append(html);
            
        }
                }); 
    };


    function myEmployeeTopicFunction(subjectid){
    var urlLink = "/curriculum/employee_topic";
      
        $.ajax({
            url: urlLink ,
            data:{"mg_subjects_id":subjectid},
            cache: false,
            success: function(html){
               
                //alert("hii")
            //console.log(html);
            $("#EmploTopicID").empty();
            $("#EmploTopicID").append(html);
            
        }
                }); 
    };



    $(document).on("click", ".delete-curr-grade-btn", function(e){
     e.preventDefault();
                var myID =$(this).attr('id');
            var Id=myID.split("-");
                var retVal = confirm("Are you sure to delete?");
                if(retVal){
                  //  alert(retVal);
                     var urlLink = "/curriculum/grade_delete/"+Id[0];
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


    $(document).on("click", ".delete-curr-course-btn", function(e){
     e.preventDefault();
                var myID =$(this).attr('id');
            var Id=myID.split("-");
                var retVal = confirm("Are you sure to delete?");
                if(retVal){
                  //  alert(retVal);
                     var urlLink = "/curriculum/course_delete/"+Id[0];
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
    
   
    