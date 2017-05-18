class NotificationMailer < ActionMailer::Base
  default from: "from@mindcomgroup.com"

    def send_mail new_mail
	    @message = new_mail
	    mail(
	    	to: @message.to_user_id,
	    	:subject => @message.subject,
	    	:from => @message.from_user_id,
	    	:body => @message.description)
    end
    
    def send_time_table(new_mail, time_table)
    	puts "---------------------------------------------------------------------------------"
    	@message = new_mail
	    mail(
	    	to: @message.to_user_id,
	    	:subject => @message.subject,
	    	:from => @message.from_user_id,
	    	:body => @message.description) do |format|
  			format.text { render plain: @message.description }
  			format.html { render :partial => "send_time_table", :object => @time_table=time_table }
		end
    	puts "---------------------------------------------------------------------------------"

    end

    def send_mail_to_student(stu_id,session_id)      
    @student_name=MgStudentAdmission.find_by(:id=>stu_id)
    @exam_detail = MgEntranceExamDetail.find_by(:id=>@student_name.mg_entrance_exam_details_id,:is_deleted=>0,:mg_school_id=>session_id,:mg_course_id=>@student_name.mg_course_id)
    @course_name = MgCourse.find_by(:id=>@student_name.mg_course_id, :is_deleted=>0,:mg_school_id=>session_id)
    @school=MgSchool.find_by(:id=>session_id)
    @school_logo=@school.logo.url(:medium,:timestamp=>false)
    @date_format = MgSchool.find_by(:id=>session_id).date_format      
    @session_id = session_id
    attachments["hall_ticket#{stu_id}.pdf"] = File.read("#{Rails.root}/public/student_hall_ticket/hall_ticket#{stu_id}.pdf")
    File.delete("#{Rails.root}/public/student_hall_ticket/hall_ticket#{stu_id}.pdf")
    mail(:to=>@student_name.mg_email_id,subject:"Exam Hall Ticket")          
  end

    def send_mail_to_mgstudent(student_id,session_id, mg_examination_detail_id)      
        @student_name=MgStudent.find_by(:id=>student_id)
        @studentUserId= @student_name.mg_user_id
        @email=MgEmail.where(:mg_user_id=> @studentUserId)
        #@course_name = MgCourse.find_by(:id=>@student_name.mg_course_id, :is_deleted=>0,:mg_school_id=>session_id)
        @school=MgSchool.find_by(:id=>session_id)
        @school_logo=@school.logo.url(:medium,:timestamp=>false)
        @date_format = MgSchool.find_by(:id=>session_id).date_format
        @batch_name = MgBatch.find_by(:id=> @student_name.mg_batch_id)
        @examination_detail = MgExaminationDetail.find_by(:id=>mg_examination_detail_id)
        @time_table=MgExaminationTimeTable.where(:mg_examination_detail_id=>mg_examination_detail_id, :is_deleted=>0, :mg_school_id=>@school.try(:id), :mg_batch_id=>@student_name.mg_batch_id).order(:date, :start_time)   
        @course_name = MgCourse.find_by(:id=>@batch_name.mg_course_id, :is_deleted=>0,:mg_school_id=>session_id)
        
        attachments["hall_ticket#{student_id}.pdf"] = File.read("#{Rails.root}/public/student_hall_ticket/hall_ticket#{student_id}.pdf")
        File.delete("#{Rails.root}/public/student_hall_ticket/hall_ticket#{student_id}.pdf")
        mail(:to=>@email[0].try(:mg_email_id),subject:"Exam Hall Ticket")          
    end
end
