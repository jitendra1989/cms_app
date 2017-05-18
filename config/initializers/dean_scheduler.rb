require 'rubygems'
require 'rufus/scheduler'
 
## to start scheduler
 scheduler = Rufus::Scheduler.new
 scheduler.every '1d' do
  # do something
 @@schools=MgSchool.where(:is_deleted=>0,:id=>1)
@employee_curriculum_pending=MgEmployeeCurriculum.where(:is_deleted=>0,:mg_school_id=>@@schools[0].id,:status=>"Pending")
	@employee_curriculum_pending.each do |pending|
		temp=pending.created_at.strftime("%d/%m/%Y")
		temp1=Time.now.strftime("%d/%m/%Y")
		day_count=(temp1.to_date - temp.to_date).to_i
				if day_count<7
					# ===========================================================================================



	emp_id=MgEmployee.find_by(:is_deleted=>0,:mg_school_id=>@@schools[0].id,:id=>pending.mg_employee_id)
    reason=""
    course=MgCourse.find_by(:is_deleted=>0,:mg_school_id=>@@schools[0].id,:id=>pending.mg_course_id)
    subject=""
    if course.course_name.present?
      subject="Curriculum for #{course.course_name} \n "
     # subject="Curriculum for #{} \n "
    end
    sub=MgSubject.find_by(:is_deleted=>0,:mg_school_id=>@@schools[0].id,:id=>pending.mg_subject_id)
    if sub.subject_name.present?
      subject=subject+"Subject =#{sub.subject_name}"
    end
    title=""
    if (emp_id.first_name && emp_id.last_name).present?
    title="New Curriculum is created by #{emp_id.first_name} #{emp_id.last_name}"
    else
    title="New Curriculum is created"
    end
    reason="Please review the curriculum plan for further process. "

    @employee_dean=MgEmployee.where(:is_deleted=>0,:mg_school_id=>@@schools[0].id,:is_dean=>true)
    if @employee_dean[0].present?
          @employee_dean.each do |dean|
            send_mail_particular_employee(dean.id,reason,subject,title,emp_id.mg_user_id)
          end
    else
      flash[:notice]="Dean is not present"
    end







					# ===============================================================================================
				end

	end
end



def send_mail_particular_employee(mg_employee_id, reason, subject , title,sender_employee_user_id)
 @@schools=MgSchool.where(:is_deleted=>0,:id=>1)
 @@user_id=sender_employee_user_id
 puts "9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999"
 puts sender_employee_user_id
 puts "9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999"

  user=MgEmployee.find_by(:is_deleted=>0, :id=>mg_employee_id)
  if user.present?

    msg="Dear Sir/Madam \n\n\n"
    msg +="\t #{title.to_s} "

    msg +=" #{reason.to_s} \n\n\n"
    msg +="Thanks & Regards \n #{@@schools[0].school_name}"


      begin
      @email_from = MgEmail.where(:mg_user_id => @@user_id)
      @message = Message.new
      @message.subject =  " #{subject.to_s}"
      @message.description =msg.to_s

            # all_user.each do |user|
                @email_to = MgEmail.where(:mg_user_id => user.mg_user_id)
puts "===========63463545645345634564564563456==============="
puts user.mg_user_id
puts @@user_id
puts "============dsfkljkldfsgjlksdfjg;lsdfkg;o============"
                      if @email_to.present?
                        @message.to_user_id = @email_to[0][:mg_email_id ]
                      @message.from_user_id = @email_from[0][:mg_email_id ]
                  db_user = MgNotification.create(:mg_school_id => @@schools[0].id ,
                                  :to_user_id => user.mg_user_id.to_i,
                                  :subject => @message.subject,
                                  :description => @message.description,
                                  :is_deleted => 0,
                                  :from_user_id =>@@user_id,
                                  :status => 0)
                  server_response = NotificationMailer.send_mail(@message).deliver!
                  
                        @event_mail = MgMailStatus.create(:status_code => server_response.status,
                                                    :email_addrs_to => @message.to_user_id,
                                                    # current school Id will come here
                                          :mg_school_id => @@schools[0].id ,
                                                    :email_addrs_by => @message.from_user_id,
                                                    :email_subject => 'test',
                                                   :email_server_description => server_description(server_response.status) )
                      else
                        puts "Email id is not present"
                      end

            # end
              return @notice="Mail Sent Successfully"
            rescue Net::SMTPFatalError => e
              return @notice= 'Email-Id is not valid.'
              puts e
            rescue ArgumentError=>e
              puts e
              return @notice='Email to address is not present.'
            rescue Exception=>e
              puts e
             return  @notice='Error while sending email,Please contact admin.'
            end
      



  end


end





def server_description(code_s)
    
    case code_s.to_s

          when '0'
              return "Email address is not correct"
        
          when '211'   
              return "A system status message."
          when '214'   
              return "A help message for a human reader follows."
          when '220'   
              return "SMTP Service ready."
          when '221'   
              return "Service closing."
          when '250'   
              return "Requested action taken and completed. The best message of them all."
          when '251'   
              return "The recipient is not local to the server, but the server will accept and forward the message."
          when '252'   
              return "The recipient cannot be VRFYed, but the server accepts the message and attempts delivery."
          when '354'   
              return "Start message input and end with . This indicates that the server is ready to accept the message itself (after you have told it who it is from and where you want to to go)."



          when '421'   
              return "The service is not available and the connection will be closed."
          when '450'   
              return "The requested command failed because the users mailbox was unavailable (for example because it was locked). Try again later."
          when '451'   
              return "The command has been aborted due to a server error. Not your fault. Maybe let the admin know."
          when '452'   
              return "The command has been aborted because the server has insufficient system storage."


          when '500'   
              return "The server could not recognize the command due to a syntax error. "

          when '501'   
              return "A syntax error was encountered in command arguments."
          when '502'   
              return "This command is not implemented."
          when '503'   
              return "The server has encountered a bad sequence of commands."
          when '504'   
              return "A command parameter is not implemented."

          when '550'   
              return "The requested command failed because the users mailbox was unavailable (for example because it was not found, or because the command was rejected for policy reasons)."
          when '551'   
              return "The recipient is not local to the server. The server then gives a forward address to try."
          when '552'   
              return "The action was aborted due to exceeded storage allocation."
          when '553'   
              return "The command was aborted because the mailbox name is invalid."
          when '554'   
              return "The transaction failed. Blame it on the weather."
          
    end
   
  end






