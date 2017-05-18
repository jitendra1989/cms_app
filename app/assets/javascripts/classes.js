/* comm */

(function($) {

  $.fn.update_course_success = function(){
    // close modal
 //   this.modal('hide');
		//	alert("Step-2");
    // clear form input elements
    // todo/note: handle textarea, select, etc
 //   this.find('form input[type="text"]').val('');

    // clear error state
  //  this.clear_previous_errors();
  };

  }(jQuery));



$(document).on("click", ".batch-edit", function(e){
        var myID =$(this).attr('id');
        var urlLink = "/classes/edit/"+myID;
        //alert(urlLink);
        $.ajax({
            url: urlLink ,
            cache: false,
            success: function(html){
               /* $("#dialogID").empty();
                $("#dialogID").append(html);*/

                  $('<div></div>').dialog({
                    modal: true,
                    title: "Edit Class",

                    open: function () {
                        
                        $(this).html(html);
                    }
                }); //end confirm dialog
               
            }
        });
});