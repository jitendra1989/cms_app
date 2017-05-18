function myFunction123(batchid){
  var urlLink = "/exam_management/examination_grades_show";
  $.ajax({
    url: urlLink ,
    data:{"mg_batch_id":batchid},
    cache: false,
    success: function(html){
      // alert("hii")
      if (html.name==""){
        $("#tableID").empty();
        var str='<button  class="gradess-classes mg-custom-form-btn">Add Grades </button><br/><br/>'
        $("#tableID").append(str);
      }else{
        var str='<button  class="gradess-classes mg-custom-form-btn">Add Grades </button><br/><br/>'
        str +='<table class="batch-tbl" cellspacing="0" style="padding:0;width:100%;height:100%; border-collapse:collapse;"><tr class="subject-table-header" rowspan="2"><th>Grades</th><th>Description</th><th>Min Score</th><th>Credit Points</th><th>Actions</th></tr>';

        for (var key in html.name) 
        {
          var value=html.name[key];
          name=value.name;
          description=value.description;
          if(description!=''){
            var temp_description = description.substring(0,25)+"...";
          }else{
            var temp_description = description
          }


          min_score=value.min_score;
          credit_points=value.credit_points;
          id=value.id
          str+='<tr><td class="mg-align-center">'+name+'</td><td>'+temp_description+' </td><td class="mg-align-center">'+min_score+'</td><td class="mg-align-center">'+credit_points+'</td><td class="mg-align-center"><a  id='+id+' class="show-exam-classes"><button title="Show" class="mg-text-exam mg-icon-btn mg-right-align"><i class="fa fa-eye"></i></button></a><a  id='+id+' class="editss-classes"><button title="Edit" class="mg-text-exam mg-icon-btn mg-right-align"><i class="fa fa-pencil-square-o"></i></button></a><a  id='+id+' class="deletes-classes"><button title="Delete" class="mg-text-exam mg-icon-btn"><i class="fa fa-trash"></i></button></a></td></tr>';
        }
        str +='</table>';
        $("#tableID").empty();
        $("#tableID").append(str);
      }
    }
  }); 
};


       $(document).on("click", ".gradess-classes", function(e){
        var urlLink = "/exam_management/examination_grades_add_grades/";
        var batchId=$("#mg_batch_id").val();
        if(batchId!=""){
        $.ajax({
            url: urlLink ,
            cache: false,
            data:
            {
                "batch_id":batchId
            },
            success: function(html){  
                    $('#examinationClassID').dialog({
                    modal: true,
                    title: "Add Student Grades",
                    // minWidth: 350,
                    // minHeight: 350,
                    // maxHeight: 500,
                    open: function () {
                        
                        $(this).html(html);
                    }
                }); 
               
            }
        });
    }
    else{

        alert("Please Select Course");
    }
});


$(document).on("click", ".editss-classes", function(e){
  var Id=$(this).attr('id');
  var urlLink = "/exam_management/examination_grades_edit/";
  $.ajax({
    url: urlLink ,
    cache: false,
    data:{"id":Id},
    success: function(html){  
      $('#editClassID').dialog({
        modal: true,
        title: "Edit Student Grades",
        minWidth: 300,
        minHeight: 320,
        // maxHeight: 500,
        open: function(){
          $(this).html(html);
        }
      }); 
    }
  });
});

$(document).on("click", ".show-exam-classes", function(e){
  var Id=$(this).attr('id');
  var urlLink = "/exam_management/show_examination_grades/";
  $.ajax({
    url: urlLink ,
    cache: false,
    data:{"id":Id},
    success: function(html){  
      $('#showClassID').dialog({
        modal: true,
        title: "Show Student Grades",
        minHeight: 'auto',
        width: 'auto',
        // maxHeight: 500,
        open: function(){
          $(this).html(html);
        }
      }); 
    }
  });
});


$(document).on("click", ".deletes-classes", function(e){
  var Id =$(this).attr('id');

    // var splString = myID.split("-");
    var retVal = confirm("Are you sure to delete ?");
        if(retVal)
        {
            var urlLink = "/exam_management/examination_grades_destroy/";
            $.ajax({
            url: urlLink ,
            data:{"id":Id},
            cache: false,
            success: function(html)
            {
                window.location.reload();            
            }
            }); 

        }
         
});  








$(document).on("click","#button_for_data_submission",function(){




        var student_id=$("#mg_student_id").val();
        var exam_id=$("#mg_exam_detail_id").val();
        var batch=$("#mg_batch_id").val();
        var program_category=$("#mg_examination_program_category_id").val();
        var category=$("#mg_examination_category_id").val();
        var wing=$("#mg_wing_id").val();
        

      if (student_id==""||exam_id==""||batch==""||program_category==""||category==""||wing==""){
        alert("Please Select Manditory Fields");

      }

      else{

var urlLink="/exam_management/report_generation_for_student_data/"
$.ajax({ 
               url: urlLink,  
               cache: false,
               data:{"id":student_id,"exam_type":exam_id,"batch_id":batch},
               success: function(data){
                //$(that).parents('td').siblings(".resource-category-td-class").html(data);
                  $("#data_for_generating_report").empty().append(data);
                  //temp.append(data);
                }
           });
}
});



$(document).on("click", ".new-add-exam-type", function(e){
        // var myID =$(this).attr('id');
        // var Id=myID.split("-");

        var urlLink = "/exam_management/new";
        $.ajax({
            url: urlLink ,
            cache: false,
            success: function(html){
                  $('#newExamTypeDIVID').dialog({
                    modal: true,
                    minHeight: 'auto',
                    title: "New Exam Type",
                    open: function () {
                        
                        $(this).html(html);
                    }
                }); 
               
            }
        });
});

$(document).on("click", ".edit-exam-type-btn", function(e){
        var myID =$(this).attr('id');
        var Id=myID.split("-");


        var urlLink = "/exam_management/"+Id[0]+"/edit/";
        $.ajax({
            url: urlLink ,
            cache: false,
            success: function(html){
                  $('#editExamTypeDIVID').dialog({
                    modal: true,
                    minHeight: 'auto',
                    title: "Edit Exam Type",
                    open: function () {
                        
                        $(this).html(html);
                    }
                }); 
               
            }
        });
});


$(document).on("click", ".show-exam-type-btn", function(e){
        var myID =$(this).attr('id');
        var Id=myID.split("-");



        var urlLink = "/exam_management/"+Id[0];
        $.ajax({
            url: urlLink ,
            cache: false,
            success: function(html){
                  $('#showExamTypeDIVID').dialog({
                    modal: true,
                    minHeight: 200,
                    maxHeight: 400,
                    width: 'auto',
                    // maxWidth: 600,
                    title: "Show Exam Type",
                    open: function () {
                        
                        $(this).html(html);
                    }
                }); 
               
            }
        });
});


$(document).on("click", ".delete-exam-type-btn", function(e){
     
                var myID =$(this).attr('id');
                    var Id=myID.split("-");


                
                var retVal = confirm("Are you sure to delete?");
                if(retVal){
                  //  alert(retVal);
                     var urlLink = "/exam_management/delete/"+Id[0];

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


// hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh


$(document).on("click", ".new-add-examination-category", function(e){
        // var myID =$(this).attr('id');
        // var Id=myID.split("-");

        var urlLink = "/exam_management/examination_category_new";
        $.ajax({
            url: urlLink ,
            cache: false,
            success: function(html){
                  $('#newExaminationCategoryDIVID').dialog({
                    modal: true,
                    minHeight: 'auto',
                    title: "New Examination Category",
                    open: function () {
                        
                        $(this).html(html);
                    }
                }); 
               
            }
        });
});

$(document).on("click", ".edit-examination-category-btn", function(e){
        var myID =$(this).attr('id');
        var Id=myID.split("-");


        var urlLink = "/exam_management/examination_category_edit/"+Id[0];
        $.ajax({
            url: urlLink ,
            cache: false,
            success: function(html){
                  $('#editExaminationCategoryDIVID').dialog({
                    modal: true,
                    minHeight: 'auto',
                    title: "Edit Examination Category",
                    open: function () {
                        
                        $(this).html(html);
                    }
                }); 
               
            }
        });
});


$(document).on("click", ".show-examination-category-btn", function(e){
        var myID =$(this).attr('id');
        var Id=myID.split("-");



        var urlLink = "/exam_management/examination_category_show/"+Id[0];
        $.ajax({
            url: urlLink ,
            cache: false,
            success: function(html){
                  $('#showExaminationCategoryDIVID').dialog({
                    modal: true,
                    minHeight: 200,
                    maxHeight: 400,
                    width: 'auto',
                    // maxWidth: 600,
                    title: "Show Examination Category",
                    open: function () {
                        
                        $(this).html(html);
                    }
                }); 
               
            }
        });
});


$(document).on("click", ".delete-examination-category-btn", function(e){
     
                var myID =$(this).attr('id');
                    var Id=myID.split("-");
                var retVal = confirm("Are you sure to delete?");
                if(retVal){
                  //  alert(retVal);
                     var urlLink = "/exam_management/examination_category_delete/"+Id[0];

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


$(document).on("click", ".show-show-examination-btn", function(e){
        var myID =$(this).attr('id');
        var Id=myID.split("-");
        var urlLink = "/exam_management/"+Id[0]+"/show_examination";
        $.ajax({
            url: urlLink ,
            cache: false,
            success: function(html){
                  $('#examinationShowDIVID').dialog({
                    modal: true,
                    minHeight: 200,
                    maxHeight: 400,
                    // minWidth: 200,
                    width: 'auto',
                    // maxWidth: 600,
                    title: "Show Examination Details",
                    open: function () {
                        
                        $(this).html(html);
                    }
                }); 
               
            }
        });
});

$(document).on("click", ".delete-delete-examination-btn", function(e){
     
                var myID =$(this).attr('id');
                    var Id=myID.split("-");
                var retVal = confirm("Are you sure to delete?");
                if(retVal){
                  //  alert(retVal);
                     var urlLink = "/exam_management/"+Id[0]+"/delete_examination";

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


$(document).on("click", ".show-invigilators-btn", function(e){
        var myID =$(this).attr('id');
        var Id=myID.split("-");
        var urlLink = "/exam_management/"+Id[0]+"/show_invigilators";
        $.ajax({
            url: urlLink ,
            cache: false,
            success: function(html){
                  $('#invigilatorsShowDIVID').dialog({
                    modal: true,
                    minHeight: 200,
                    maxHeight: 500,
                    minWidth: 600,
                    // maxWidth: 500,
                    title: "Show Invigilators Details",
                    open: function () {
                        
                        $(this).html(html);
                    }
                }); 
               
            }
        });
});

$(document).on("click", ".delete-invigilators-btnn", function(e){
        var myID =$(this).attr('id');
        var Id=myID.split("-");
        var retVal = confirm("Are you sure to delete?");
        if(retVal){
             var urlLink = "/exam_management/"+Id[0]+"/delete_invigilators";
              $.ajax({
                url: urlLink ,
                cache: false,
                success: function(html){
                   window.location.reload();
                }
            });
        }else{   
           return false;
        }

}); 







function minFromMidnight(tm){
  if(tm==''){
    return;
  }else{
  var ampm= tm.substr(-2)
   var clk = tm.substr(0, 4);
   var m  = parseInt(clk.match(/\d+$/)[0], 10);
   var h  = parseInt(clk.match(/^\d+/)[0], 10);
   h += (ampm.match(/pm/i))? 12: 0;
   return h*60+m;
  }

}


  $(document).on("change",".start_time_picker_text_field_cls",function(){
    var from_date=$(this).val();
    var to_date=$(this).parent('.start-time-picker-text-field-cls').siblings('.end-time-picker-text-field-cls').children('input').val();
  if (from_date && to_date){
    var from = $(this).val();
    var to = $(this).parent('.start-time-picker-text-field-cls').siblings('.end-time-picker-text-field-cls').children('input').val();
    var from_time=minFromMidnight(from);
    var to_time=minFromMidnight(to);
      if(from_time && to_time){
        if(from_time > to_time){
         alert("Start Time must be less than End Time");
          this.value=""

      } 
    }
  }
});

  $(document).on("change",".end_time_picker_text_field_cls",function(){
    var to_date=$(this).val();
    var from_date=$(this).parent('.end-time-picker-text-field-cls').siblings('.start-time-picker-text-field-cls').children('input').val();
  if (from_date && to_date){
    var from = $(this).parent('.end-time-picker-text-field-cls').siblings('.start-time-picker-text-field-cls').children('input').val();
    var to = $(this).val();
    var from_time=minFromMidnight(from);
    var to_time=minFromMidnight(to);
      if(from_time && to_time){
        if(from_time > to_time){
         alert("End Time must be greater than Start Time");
          this.value=""

      } 
    }
  }
});


function selectExamShow(value, mg_examination_detail_id){
    console.log("val-----> "+value);
    var c=["mg_time_table_id","mg_exam_type_id", "mg_examination_category_id","mg_wing_id", "mg_course_id","mg_examination_program_category_id","time_table_mg_wing_id", "time_table_mg_course_id"]
     var urlLink = "/exam_management/multi_skilled_worker";
     $("#subjectListDIVID").html('');
     $("#time_table_mg_wing_id").val('');
     $("#time_table_mg_course_id").val('');
    
     if(value==''){
        for(var i in c){
            $("#"+c[i]).val("");
        }
        $("#subjectListDIVID").html('');
     }else{
        $.ajax({
            url: urlLink ,
            cache: false,
            data: {
                selecter: "mg_examination_detail_id",
                id: value
            },
            success: function(data){
               var dateFormatStr =  getJsDateFormat();
                console.log(data.main);
                for(var a in data.main){
                    for(b in data.main[a]){
                        console.log(data.main[a][b]+"  "+b);
                        if(b=='start_date' || b=='end_date'){
                          if(data.main[a][b]){
                            $("#"+b).val($.datepicker.formatDate(dateFormatStr, new Date(data.main[a][b])));
                          }else{
                            $("#"+b).val('');
                          }
                        }else{
                          $("#"+b).val(data.main[a][b]);
                        }
                    }
                    // subject_list(data.main[a].mg_course_id,data.main[a].id )
                }
            }
        });
     }
        

}

function selectSectionExamManagement(that, str_select){

  console.log(that.value+"   ~>  "+str_select);
  var urlLink = "/exam_management/multi_skilled_worker";
  var json_object={mg_wing_id: "time_table_mg_course_id", mg_course_id: "examination_mg_batch_id"};

   if("mg_wing_id"==str_select || "mg_course_id"==str_select){
          $.ajax({
              url: urlLink ,
              cache: false,
              data:{ 
                selecter: str_select,
                id: that.value
              },
              success: function(data){
                  console.log("data   ~>  "+data.main);
                  $("#"+json_object[str_select]).html(data.main);
              }
          });
   }

  
}
function subject_list(mg_course_id){
    console.log(mg_course_id);
    var mg_examination_detail_id=$("#time_table_mg_examination_detail_id").val();
    var urlLink = "/exam_management/subject_list/"+mg_course_id;
    $.ajax({
        url: urlLink ,
        cache: false,
        data:{
            mg_examination_detail_id: mg_examination_detail_id
        },
        success: function(html){
            $("#subjectListDIVID").html(html);
        }
    });
}

function countSelectedEmployee(){
    var length = $('#selected_employees').children('option').length;
    $("#invigilators_no_of_invigilators").val(length);
    // alert(length);
}

function invigilatorsSubmit(){
    $("#selected_employees option").prop('selected',true);
    countSelectedEmployee();
    $("#invigilatorsBTNID").click();
}

$(document).on("click",".delete-seating-plan-cls", function(e){
   var myID =$(this).attr('id');
   var that=$(this);
   var Id=myID.split("-");
    var retVal = confirm("Are you sure to delete?");
    if(retVal){
         var urlLink = "/seating_plan/"+Id[0]+"/delete/";
          $.ajax({
            url: urlLink ,
            cache: false,
            success: function(data){
              if(data.main){
                console.log(data.main);
                // $(that).parent('td').parent('tr').remove();
                  window.location.reload();
              }else{
                alert("Not Deleted, Please try again");
              }
            }
        });

    }else{
       // alert(retVal);     
       return false;
    }

});

// function select_examination_details(mg_examination_detail_id){
//   var urlLink = "/exam_management/multi_skilled_worker";
//   $.ajax({
//       url: urlLink ,
//       cache: false,
//       data:{ 
//         selecter: "examination_detail_for_seating_plan",
//         id: mg_examination_detail_id
//       },
//       success: function(data){
//           console.log("data   ~>  "+data.main);
//           $("#mg_wing_id").html(data.main);
//       }
//   });
   

// }
function select_examination_details_course(mg_wing_id){
  var mg_examination_detail_id=$("#seating_plan_mg_examination_detail_id").val();
  var mg_examination_time_table_id=$("#date_time").val();
  if(mg_examination_detail_id){
    if(mg_examination_time_table_id){
       var urlLink = "/exam_management/multi_skilled_worker";
      $.ajax({
          url: urlLink ,
          cache: false,
          data:{ 
            selecter: "mg_wing_id_for_seating_plan",
            id: mg_examination_detail_id,
            mg_wing_id: mg_wing_id, 

          },
          success: function(data){
              $("#mg_course_id").html(data.main);
          }
      });
    }else{
      alert("Please select time");
    }
  }else{
    alert("Please select examination");
  }
 
   

}

function select_examination_details_student(mg_course_id){
  var mg_institute_room_id=$("#seating_plan_mg_institute_room_id").val();
  var urlLink = "/exam_management/multi_skilled_worker";
  var mg_examination_detail_id=$("#seating_plan_mg_examination_detail_id").val();
  var mg_examination_time_table_id=$("#date_time").val();
  $.ajax({
      url: urlLink ,
      cache: false,
      data:{ 
        selecter: "mg_course_id_for_seating_plan",
        id: mg_course_id,
        mg_institute_room_id: mg_institute_room_id,
        mg_examination_time_table_id: mg_examination_time_table_id,
        mg_examination_detail_id: mg_examination_detail_id
      },
      success: function(data){
          $("#selected_student").html(data.main);
      }
  });
}

$(document).on("click","#addingStudentID",function(e){
  var demo=$("#selected_student").val();
  var texts=$("#selected_student :selected").text();
  var text=texts.split(" ");

  var array=[];
  $("#mg_student_id option").each(function() {
      array.push(this.value);
    }
  );0

  for(var i=0;i<demo.length;i++)
  {
    var a =false;
      for(var j=0;j<array.length;j++){
        if (demo[i]==array[j]){
          a=true;
        }
      }
    if (a){
    }else{
      var addselectedOption=$("#selected_student option:selected")
      var str="<option value="+demo[i]+">"+text[i]+"</option>"
        $("#mg_student_id").append(str);
      $("#mg_student_id option").prop('selected',true);
    }
  }
  $("#selected_student :selected").remove();
  countSelectedStudent();
 });

$(document).on("click","#removingdataFromSeatingPlanID",function(e){
  var selectedOption=$("#mg_student_id option:selected").remove();
  $("#mg_student_id option").prop('selected',true);
  countSelectedStudent();
});


function countSelectedStudent(){
    var length = $('#mg_student_id').children('option').length;
    $("#totalStudentSelectedSPANID").html(length);
    $("#seating_plan_seat_available").val($("#seating_plan_total_seats").val()-length);
    $.validator.addMethod('selectlength', function(value, element, param) {
        return $('#seating_plan_total_seats').val() >= param;
    }, "Total selected students should not be more than total number of seats");
    
      $("#mg_student_id").val($("#mg_student_id").val()).rules("add", {
          selectlength: $('#mg_student_id').children('option').length
          
      });
    // sortSelectedStudent();

}
// 
function select_examination_details_employee_specialization(mg_employee_specialization_id){
  var date_time=$("#date_time").val();
  var mg_examination_detail_id=$("#seating_plan_mg_examination_detail_id").val();
  if(date_time){
     var urlLink = "/exam_management/multi_skilled_worker";
    $.ajax({
        url: urlLink ,
        cache: false,
        data:{ 
          selecter: "mg_employee_specialization_id_for_seating_plan",
          id: mg_employee_specialization_id,
          mg_examination_detail_id: mg_examination_detail_id,
          date_time: date_time
        },
        success: function(data){
            $("#seating_plan_mg_institute_room_id").html(data.main);
        }
    });
  }else{
    alert("Please select date and time");
    $("#seating_plan_mg_employee_specialization_id").val('');
  }
 
   

}
// 


$(document).on("click", ".show-seating-plan-cls", function(e){
        var myID =$(this).attr('id');
        var Id=myID.split("-");
        var urlLink = "/seating_plan/"+Id[0]+"/show";
        $.ajax({
            url: urlLink ,
            cache: false,
            success: function(html){
                  $('#seatingPlanShowDIVID').dialog({
                    modal: true,
                    minHeight: 200,
                    maxHeight: 500,
                    minWidth: 600,
                    // maxWidth: 500,
                    title: "Show seating plan",
                    open: function () {
                        
                        $(this).html(html);
                    }
                }); 
               
            }
        });
});

// function sortSelectedStudent(){
//     var options = $('#mg_student_id option');
//     var arr = options.map(function(_, o) {
//         return {
//             t: $(o).text(),
//             v: o.value
//         };
//     }).get();
//     arr.sort(function(o1, o2) {
//         return o1.t > o2.t ? 1 : o1.t < o2.t ? -1 : 0;
//     });
//     options.each(function(i, o) {
//         console.log(i);
//         o.value = arr[i].v;
//         $(o).text(arr[i].t);
//     });
// }

$(document).on("click", ".delete-store-manager-btn", function(e){
  e.preventDefault();
  var myID =$(this).attr('id');
  var Id=myID.split("-");
  var retVal = confirm("Are you sure to delete?");
  if(retVal){
    var urlLink = "/exam_management/delete_hod_login/"+Id[0];
    $.ajax({
      url: urlLink ,
      cache: false,
      success: function(html){
        window.location.reload();
      }
    });
  }
  else{
    return false;
  }
}); 