#class CurriculumManagementsController < ApplicationController
class CurriculumController < ApplicationController
  before_filter :login_required
  layout "mindcom"
  def index

  end
  

  def unit_index
    
  end

  def topic_index
    
  end

  def batchsubject_index
    @id=params[:mg_batch_id]
  end

  def curriculum_index
    # puts "session................userid.................."
    # puts session[:user_id]

    # puts "=========================9999999999999999"
    # @studentuserid=session[:user_id]
    # @guardianuserid=session[:user_id]
    
    # @studentuserid=MgStudent.where(:mg_user_id =>session[:user_id])
    # @guardianuserid=MgGuardian.where(:mg_user_id => session[:user_id])
    
     #    if  (!(@studentuserid[0].to_s.empty?))
     #    @studentbatchid=MgStudent.where(:mg_user_id => session[:user_id]).pluck(:mg_batch_id)
     #    elsif (!(@guardianuserid[0].to_s.empty?))
     #      @guardian=MgGuardian.where(:mg_user_id => session[:user_id]).pluck(:mg_student_id)
     #      @studentbatchid=MgStudent.where(:mg_student_id => @guardian).pluck(:mg_batch_id)
     #      else 
     #      @studentbatchid=MgBatch.where(:is_deleted=0).pluck(:mg_batch_id)
    #         end
  end
def create
  @curriculum=MgSyllabus.new(curr_params)
  @curriculum.save
  
    redirect_to :action => "class_show"
end
def unit_create
  @curriculum=MgUnit.new(unit_params)
  @curriculum.save
  @employee_id=MgEmployee.find_by(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_user_id=>session[:user_id])
  if @employee_id.id.present?
  @curriculum.update(:mg_employee_id=>@employee_id.id)
  end
    redirect_to :action => "unit_show"
end

def topic_create
  @curriculum=MgTopic.new(topic_params)
  @curriculum.save
  @employee_id=MgEmployee.find_by(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_user_id=>session[:user_id])
  if @employee_id.id.present?
  @curriculum.update(:mg_employee_id=>@employee_id.id)
  end
    redirect_to :action => "topic_show"
end
def batch_syllabus_create
  puts params[:mg_batch_id].inspect
  @curriculum=MgBatchSyllabus.new(batchsyllabus_params)
  @curriculum.save
  #params[:topic_name]=Topic.where(:id => params[:topic_name]).pluck(:name)
  @curriculum.update(
          :mg_batch_id => params[:mg_batch_id],
          :mg_subject_id => params[:mg_subject_id],
          :topic_name => params[:topic_name])
   redirect_to :back
   #redirect_to :action => "class_show"
end

def student_curriculum_create
  @curriculum=MgCurriculum.new(curric_params)
  @curriculum.save
  @curriculum.update(
          :mg_subject_id => params[:mg_subject_id],
          :mg_topic_id => params[:mg_topic_id])
  #redirect_to :back
  redirect_to :action => "curriculum_index"
end

def batch_syllabus_edit
  @curriculum = MgBatchSyllabus.find(params[:id])
end

def subject_edit
  @curriculum = MgSyllabus.find(params[:id])
  puts "params[:id]"
  puts params[:id]
  puts"==============================="
  #render :layout => false
end

def unit_edit
  @curriculum = MgUnit.find(params[:id])
  puts "params[:id]"
  puts params[:id]
  puts"==============================="
  #render :layout => false
end

def topic_edit
  @curriculum = MgTopic.find(params[:id])
  puts "params[:id]"
  puts params[:id]
  puts"==============================="
  #render :layout => false
end

def batchsubject_new
  @demo=params[:mg_batch_id]
  puts "778888888888888888888888"
  puts @demo.inspect
  puts "778888888888888888888888"
  render :layout => false
end

def batchsubject_syllabus
  @value=params[:mg_subjects_id]
  puts "888888888888888888888"
  puts params[:mg_subjects_id]
  puts "8888888888888888"
  render :layout => false
  
end
def student_syllabus
  render :layout => false
end

def employee_subject
  render :layout => false
  
end

def employee_topic
  render :layout => false
  
end

# def update
# puts "update"
# puts params[:id]
# puts "8888888888888888888"
#   @curriculum_managements = Syllabus.find(params[:id])
#   puts"in only update method 888888888888885555555555555555555555"
     
#       if @curriculum_managements.update(curr_params)
#         redirect_to :controller => "curriculum_managements" , :action => "class_show"
#       else
#         render 'edit'
#       end
  
  
# end





def subject_update
  puts"in subject update method 888888888888885555555555555555555555"
      @curriculum = MgSyllabus.find(params[:id])
      puts "--------------------------------------------------"
      puts params[:mg_subject_id]
     puts "================================================="
     puts params
     puts "================================================="
      if @curriculum.update(curr_params_update)
        @curriculum.update(:mg_subject_id=>params[:mg_subject_id],:mg_course_id=>params[:mg_course_id])
        redirect_to :controller => "curriculum" , :action => "class_show"
      else
        render 'subject_edit'
      end
end



def batch_syllabus_update
  
   @curriculum = MgBatchSyllabus.find(params[:id])
     
      if @curriculum.update(batc_params)
        redirect_to :controller => "curriculum" , :action => "batch_syllabus_show"
      else
        render 'subject_edit'
      end





end





def unit_update
      @curriculum = MgUnit.find(params[:id])
      if @curriculum.update(unit_params_update)
        @curriculum.update(:mg_wing_id=>params[:mg_wing_id],:mg_subject_id=>params[:mg_subject_id],:mg_course_id=>params[:mg_course_id],:mg_syllabus_id=>params[:mg_syllabus_id])
        redirect_to :controller => "curriculum" , :action => "unit_show"
      else
        render 'unit_edit'
      end
end

def topic_update
  puts"in subject update method 888888888888885555555555555555555555"
      @curriculum = MgTopic.find(params[:id])
      if @curriculum.update(topics_params)
        @curriculum.update(:mg_wing_id=>params[:mg_wing_id],:mg_course_id=>params[:mg_course_id],:mg_subject_id=>params[:mg_subject_id],:mg_syllabus_id=>params[:mg_syllabus_id],:mg_unit_id=>params[:mg_unit_id])
        redirect_to :controller => "curriculum" , :action => "topic_show"
      else
        render 'topic_edit'
      end
end

def  subject_delete
    @curriculum = MgSyllabus.find(params[:id])
      
      if @curriculum.update(:is_deleted => 1)
        render 'class_show'
        else
      
      end
  end


  def  unit_delete
    @curriculum = MgUnit.find(params[:id])
      
      if @curriculum.update(:is_deleted => 1)
        render 'unit_show'
        else
      
      end
  end


  def batch_syllabus_delete
    @curriculum = MgBatchSyllabus.find(params[:id])
      
      if @curriculum.update(:is_deleted => 1)
        render 'batch_syllabus_show'
        else
      
      end
  end


  def  topic_delete
    @curriculum = MgTopic.find(params[:id])
    @curriculum.update(:is_deleted => 1)
    redirect_to :action=>'topic_show'
      
  end

def batch_syllabus_show
 
end


  def saveBatch

    @selected_batches1 = params[:selected_batches1]
    puts "8888888888888888"
     
    @aa = params[:curriculum]
    puts @aa[:mg_syllabus_id]
    puts "88888888888888"
        for i in 0...@selected_batches1.size
          @batchsyllabus=MgBatchSyllabus.new(batch_params)
           @batchsyllabus.mg_batch_id=@selected_batches1[i]
      @batchsyllabus.mg_syllabus_id=params[:curriculum][:mg_syllabus_id]
      @batchsyllabus.is_deleted=params[:curriculum][:is_deleted]
           
          @batchsyllabus.save
        end

   render 'batch_syllabus_show'
   

  end


  def grade
    @curriculum_grade=MgCurriculumGrade.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id]).paginate(page: params[:page], per_page: 10)
  end

  def grade_new
    render :layout => false
    #@curriculum=MgCurriculumGrade.find(params[:id])
  end

  def grade_create
    @curriculum=MgCurriculumGrade.new(params_grade)
    @curriculum.save
    redirect_to :action=>"grade"
  end

  def grade_edit
    @curriculum=MgCurriculumGrade.find(params[:id])
    render :layout => false

    #@curriculum.update(params_grade_update)
  end

  def grade_update
    @curriculum=MgCurriculumGrade.find(params[:id])
    @curriculum.update(params_grade_update)
    redirect_to :action=>"grade"
  end

  def grade_delete
    @curriculum=MgCurriculumGrade.find(params[:id])
    @curriculum.update(:is_deleted=>1)
    redirect_to :action=>"grade"
  end

  def grade_show
    @grade=MgCurriculumGrade.find(params[:id])
    render :layout => false
  end

# ========================================================================================

def course
    @curriculum_type=MgCurriculumCourse.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id]).paginate(page: params[:page], per_page: 10)
  end

  def course_new
    render :layout => false
  end

  def course_create
    @curriculum=MgCurriculumCourse.new(params_course)
    @curriculum.save
    redirect_to :action=>"course"
  end

  def course_edit
    @curriculum=MgCurriculumCourse.find(params[:id])
    render :layout => false
  end

  def course_update
    @curriculum=MgCurriculumCourse.find(params[:id])
    @curriculum.update(params_course_update)
    redirect_to :action=>"course"
  end

  def course_delete
    @curriculum=MgCurriculumCourse.find(params[:id])
    @curriculum.update(:is_deleted=>1)
    redirect_to :action=>"course"
  end

  def course_show
    @course=MgCurriculumCourse.find(params[:id])
    render :layout => false
  end

def semester_list
      @course_list = MgCourse.where(:is_deleted=>0, :mg_wing_id=>params[:id], :mg_school_id=>session[:current_user_school_id])#.pluck(:id, :first_name)
      respond_to do |format|
      format.json  { render :json => @course_list }
      end
  end



  def wing_list
      @wing_id_list=MgSyllabus.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_timetable_id=>params[:id]).pluck(:mg_wing_id).uniq
      @wing_list = MgWing.where("is_deleted=? and mg_school_id=? and id IN (?)",0,session[:current_user_school_id],@wing_id_list)#.pluck(:id, :first_name)
      respond_to do |format|
      format.json  { render :json => @wing_list }
      end
  end

        
        # <%#=f.collection_select(:mg_batch_id, @batchList , :id, :name, {:include_blank => 'Select'} ,:class=>"mg-select-btn") %>
   
  def semester_batch_list
            @batchList = MgBatch.where(:mg_course_id=>params[:id],:is_deleted => 0, :mg_school_id=>session[:current_user_school_id])                     
            @batchList.each do |batchObj|
            @courseObj = MgCourse.find_by_id(batchObj.mg_course_id)
            batchObj.name = (@courseObj.course_name) +"-"+ batchObj.name
          end
          respond_to do |format|
          format.json  { render :json => @batchList }
      end
  end

  def subject_paper_list

      @subject_list = MgSubject.where(:is_deleted=>0, :mg_course_id=>params[:id], :mg_school_id=>session[:current_user_school_id])#.pluck(:id, :first_name)
      respond_to do |format|
      format.json  { render :json => @subject_list }
      end
  end


  def subject_list
    
      @employee_id=MgEmployee.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_user_id=>session[:user_id])
      @employee_subject_list=MgEmployeeSubject.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_employee_id=>@employee_id[0].id).pluck(:mg_subject_id)

      @subject_list = MgSubject.where("is_deleted=? and mg_course_id=? and mg_school_id=? and id IN (?)",0,params[:id],session[:current_user_school_id],@employee_subject_list)#.pluck(:id, :first_name)
      
      #@subject_list = MgSubject.where(:is_deleted=>0, :mg_course_id=>params[:id], :mg_school_id=>session[:current_user_school_id])#.pluck(:id, :first_name)
      respond_to do |format|
      format.json  { render :json => @subject_list }
      end
  end


  def subject_department_wise_list
    employee=MgEmployee.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_user_id=>session[:user_id])
    @subject_list = MgSubject.where(:mg_employee_specialization_id=>employee[0].hod_specialization_id,:is_deleted=>0, :mg_course_id=>params[:id], :mg_school_id=>session[:current_user_school_id])#.pluck(:id, :first_name)
      respond_to do |format|
      format.json  { render :json => @subject_list }
      end
  end


  def syllabus_list
      @syllabus_list = MgSyllabus.where(:is_deleted=>0, :mg_subject_id=>params[:id], :mg_school_id=>session[:current_user_school_id])#.pluck(:id, :first_name)
      respond_to do |format|
      format.json  { render :json => @syllabus_list }
      end
  end

  def unit_list
      @employee_id=MgEmployee.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_user_id=>session[:user_id])
      @unit_list = MgUnit.where(:is_deleted=>0, :mg_syllabus_id=>params[:id], :mg_school_id=>session[:current_user_school_id],:mg_employee_id=>@employee_id[0].id)#.pluck(:id, :first_name)
      respond_to do |format|
      format.json  { render :json => @unit_list }
      end
  end


  def topic_list
      @employee_id=MgEmployee.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_user_id=>session[:user_id])
      @topic_list = MgTopic.where(:is_deleted=>0, :mg_unit_id=>params[:id], :mg_school_id=>session[:current_user_school_id],:mg_employee_id=>@employee_id[0].id)#.pluck(:id, :first_name)
      respond_to do |format|
      format.json  { render :json => @topic_list }
      end
  end

  def extention_list
      #@employee_id=MgEmployee.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_user_id=>session[:user_id])
      @extention_list = MgNatureOfDocument.where(:is_deleted=>0, :id=>params[:id], :mg_school_id=>session[:current_user_school_id])
      respond_to do |format|
      format.json  { render :json => @extention_list }
      end
  end


  def subject_show
    @curriculum=MgSyllabus.find_by(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:id=>params[:id])
  end

def unit_display
    @curriculum=MgUnit.find_by(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:id=>params[:id])
end

def topic_display
    @curriculum=MgTopic.find_by(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:id=>params[:id])
end






























def topic_show
  @employee_id=MgEmployee.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_user_id=>session[:user_id])
  #@curriculum=MgTopic.where(:is_deleted => '0',:mg_school_id=>session[:current_user_school_id],:mg_employee_id=>@employee_id[0].id).paginate(page: params[:page], per_page: 10)

  # ===========================================================================================================
  if params[:custom_param].present?
            temp=params[:custom_param]
            custom=temp.split("-")
              if custom[1].present?
             # @employees = MgEmployee.where(:mg_employee_department_id=>custom[1],:is_deleted => 0,:mg_employee_category_id=>1,:mg_school_id=>session[:current_user_school_id]).paginate(page: params[:page], per_page: 10) 
  @curriculum=MgTopic.where(:mg_subject_id=>custom[1],:is_deleted => '0',:mg_school_id=>session[:current_user_school_id],:mg_employee_id=>@employee_id[0].id).paginate(page: params[:page], per_page: 10)
              
              else
  @curriculum=MgTopic.where(:is_deleted => '0',:mg_school_id=>session[:current_user_school_id],:mg_employee_id=>@employee_id[0].id).paginate(page: params[:page], per_page: 10)

             # @employees = MgEmployee.where(:is_deleted => 0,:mg_employee_category_id=>1,:mg_school_id=>session[:current_user_school_id]).paginate(page: params[:page], per_page: 10) 
              end
              @id=custom[1]
        else
      # =====================================================================================
        if params[:short_subject_wise].present?
              if params[:short_subject_wise][:mg_subject_id].present?
                @value=params[:short_subject_wise][:mg_subject_id]
              else
                @value=0
              end
          else
              @value=0
          end
          if  @value!=0
              @id=params[:short_subject_wise][:mg_subject_id]
         # @employees = MgEmployee.where(:mg_subject_id=>params[:short_subject_wise][:mg_subject_id],:is_deleted => 0,:mg_employee_category_id=>1,:mg_school_id=>session[:current_user_school_id]).paginate(page: params[:page], per_page: 10)  
  @curriculum=MgTopic.where(:mg_subject_id=>params[:short_subject_wise][:mg_subject_id],:is_deleted => '0',:mg_school_id=>session[:current_user_school_id],:mg_employee_id=>@employee_id[0].id).paginate(page: params[:page], per_page: 10)
          
          else
  @curriculum=MgTopic.where(:is_deleted => '0',:mg_school_id=>session[:current_user_school_id],:mg_employee_id=>@employee_id[0].id).paginate(page: params[:page], per_page: 10)
          
          #@employees = MgEmployee.where(:is_deleted => 0,:mg_employee_category_id=>1,:mg_school_id=>session[:current_user_school_id]).paginate(page: params[:page], per_page: 10) 
          end
        end
  # ============================================================================================================

end

def employee_curriculum
  @employee_id=MgEmployee.find_by(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_user_id=>session[:user_id])
  @curriculum=MgEmployeeCurriculum.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_employee_id=>@employee_id.id).paginate(page: params[:page], per_page: 10)
end

def employee_curriculum_new
end

def review_curriculum_update
    @curriculum=MgEmployeeCurriculum.find(params[:id])
    @curriculum.update(:status=>params[:curriculum][:status],:comments=>params[:curriculum][:comments])
    if params[:curriculum][:status]=="rejected"
      reason="Please review the curriculum plan for further process. "
      subject="Rejection of curriculum plan"
      title=""
      send_mail_particular_employee(@curriculum.mg_employee_id,params[:curriculum][:comments],subject,title)
    end
    redirect_to :action=>"review_curriculum"
end


def review_curriculum_show
    @curriculum=MgEmployeeCurriculum.find_by(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:id=>params[:id])
end


def employee_curriculum_delete
    @curriculum=MgEmployeeCurriculum.find(params[:id])
    @curriculum.update(:is_deleted=>1)
    redirect_to :action=>"employee_curriculum"
end

def employee_curriculum_edit
    @curriculum=MgEmployeeCurriculum.find(params[:id])
end

def employee_curriculum_update
    @curriculum = MgEmployeeCurriculum.find(params[:id])
    @curriculum.update(employee_curriculum_update_params)
    @curriculum.update(:mg_wing_id=>params[:mg_wing_id],:mg_subject_id=>params[:mg_subject_id],:mg_course_id=>params[:mg_course_id],:mg_syllabus_id=>params[:mg_syllabus_id])
    redirect_to :controller => "curriculum" , :action => "employee_curriculum"  
end

def employee_curriculum_show
    @curriculum=MgEmployeeCurriculum.find_by(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:id=>params[:id])
end


def review_curriculum
  @curriculum=MgEmployeeCurriculum.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id])
end


def review_curriculum_edit
    @curriculum=MgEmployeeCurriculum.find(params[:id])
end

def employee_curriculum_create
  
    @employee_id=MgEmployee.find_by(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_user_id=>session[:user_id])
    @curriculum=MgEmployeeCurriculum.new(employee_curriculum_params)
    @curriculum.save
    @curriculum.update(:status=>"Pending")
    if @employee_id.id.present?
    @curriculum.update(:mg_employee_id=>@employee_id.id)
    end
    emp_id=MgEmployee.find_by(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_user_id=>session[:user_id])
    reason=""
    course=MgCourse.find_by(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:id=>params[:curriculum][:mg_course_id])
    subject=""
    if course.course_name.present?
      subject="Curriculum for #{course.course_name} \n "
     # subject="Curriculum for #{} \n "
    end
    sub=MgSubject.find_by(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:id=>params[:curriculum][:mg_subject_id])
    if sub.subject_name.present?
      subject=subject+"(#{sub.subject_name})"
    end
    title=""
    if (emp_id.first_name && emp_id.last_name).present?
    title="New Curriculum is created by #{emp_id.first_name} #{emp_id.last_name}"
    else
    title="New Curriculum is created"
    end
    reason="Please review the curriculum plan for further process. "

    @employee_dean=MgEmployee.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:is_dean=>true)
    if @employee_dean[0].present?
          @employee_dean.each do |dean|
            send_mail_particular_employee(dean.id,reason,subject,title)
          end
    else
      flash[:notice]="Dean is not present"
    end
    redirect_to :action=>"employee_curriculum"
end



def send_mail_particular_employee(mg_employee_id, reason, subject , title)
 school=MgSchool.find_by(:id=>session[:current_user_school_id])

  user=MgEmployee.find_by(:is_deleted=>0, :id=>mg_employee_id)
  if user.present?

    msg="Dear Sir/Madam \n\n\n"
    msg +="\t #{title.to_s} "

    msg +=" #{reason.to_s} \n\n\n"
    msg +="Thanks & Regards \n #{school.school_name}"


      begin
      @email_from = MgEmail.where(:mg_user_id => session[:user_id])
      @message = Message.new
      @message.subject =  " #{subject.to_s}"
      @message.description =msg.to_s

            # all_user.each do |user|
                @email_to = MgEmail.where(:mg_user_id => user.mg_user_id)

                      if @email_to.present?
                        @message.to_user_id = @email_to[0][:mg_email_id ]
                      @message.from_user_id = @email_from[0][:mg_email_id ]
                  db_user = MgNotification.create(:mg_school_id => session[:current_user_school_id] ,
                                  :to_user_id => user.mg_user_id.to_i,
                                  :subject => @message.subject,
                                  :description => @message.description,
                                  :is_deleted => 0,
                                  :from_user_id =>session[:user_id],
                                  :status => 0)
                  server_response = NotificationMailer.send_mail(@message).deliver!
                  
                        @event_mail = MgMailStatus.create(:status_code => server_response.status,
                                                    :email_addrs_to => @message.to_user_id,
                                                    # current school Id will come here
                                          :mg_school_id => session[:current_user_school_id] ,
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


def document
  @employee_id=MgEmployee.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_user_id=>session[:user_id])
  @curriculum=MgCurriculumDocument.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_employee_id=>@employee_id[0].id).paginate(page: params[:page], per_page: 10)
end


def document_new
end

def document_create
       curriculum=MgCurriculumDocument.new(document_details_params)
        timeformat = MgSchool.find(session[:current_user_school_id])
        date = Date.strptime(params[:curriculum][:until_date],timeformat.date_format)
       # assignment.created_by=session[:user_id]batch_subject_id
        @employee_id=MgEmployee.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_user_id=>session[:user_id])
        if curriculum.save
          curriculum.update(:until_date=>date,:mg_employee_id=>@employee_id[0].id)
        end
        file_arr=params[:file]
        if file_arr.present?
            for f in 0...file_arr.length
            curriculum_documentation=MgCurriculumDocumentation.new()
            curriculum_documentation.mg_employee_id=@employee_id[0].id
            curriculum_documentation.mg_curriculum_document_id=curriculum.id
            curriculum_documentation.mg_school_id=session[:current_user_school_id]
            curriculum_documentation.is_deleted=0
            curriculum_documentation.user_type="employee"
            curriculum_documentation.updated_by=session[:user_id]
            curriculum_documentation.created_by=session[:user_id]
            curriculum_documentation.file=file_arr[f]
            curriculum_documentation.save
            end
        end
    redirect_to :action=>"document"
end

def document_update
  #puts kljsdhafj
    @employee_id=MgEmployee.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_user_id=>session[:user_id])
    @curriculum = MgCurriculumDocument.find(params[:id])
    @curriculum.update(document_update_params)
    @curriculum.update(:mg_employee_id=>@employee_id[0].id,:mg_wing_id=>params[:mg_wing_id],:mg_unit_id=>params[:mg_unit_id],:mg_topic_id=>params[:mg_topic_id],:mg_subject_id=>params[:mg_subject_id],:mg_course_id=>params[:mg_course_id],:mg_syllabus_id=>params[:mg_syllabus_id])
    if params[:curriculum][:until_date].present?
    timeformat = MgSchool.find(session[:current_user_school_id])
    date = Date.strptime(params[:curriculum][:until_date],timeformat.date_format)
    @curriculum.update(:until_date=>date)
  end
    file_arr=params[:file]
        if file_arr.present?
            for f in 0...file_arr.length
            curriculum_documentation=MgCurriculumDocumentation.new()
            curriculum_documentation.mg_employee_id=@employee_id[0].id
            curriculum_documentation.mg_curriculum_document_id=@curriculum.id
            curriculum_documentation.mg_school_id=session[:current_user_school_id]
            curriculum_documentation.is_deleted=0
            curriculum_documentation.user_type="employee"
            curriculum_documentation.updated_by=session[:user_id]
            curriculum_documentation.created_by=session[:user_id]
            curriculum_documentation.file=file_arr[f]
            curriculum_documentation.save
            end
        end
    redirect_to :action=>"document" 
end

def attachment_document_delete
  document=MgCurriculumDocumentation.find(params[:id])
  document.update(:is_deleted=>1)
  redirect_to :action=>"index"
  #redirect_to :back
end

def document_delete
    @curriculum=MgCurriculumDocument.find(params[:id])
    @curriculum.update(:is_deleted=>1)
    redirect_to :action=>"document"
end

def document_edit
    @curriculum=MgCurriculumDocument.find(params[:id])
end



def document_show
    @curriculum=MgCurriculumDocument.find_by(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:id=>params[:id])
end





# ================================================================================================





def notes
  @employee_id=MgEmployee.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_user_id=>session[:user_id])
  @curriculum=MgCurriculumNotes.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_employee_id=>@employee_id[0].id).paginate(page: params[:page], per_page: 10)
end


def notes_new
end

def notes_create


  curriculum=MgCurriculumNotes.new(notes_details_params)
        timeformat = MgSchool.find(session[:current_user_school_id])
        date = Date.strptime(params[:curriculum][:until_date],timeformat.date_format)
       # assignment.created_by=session[:user_id]batch_subject_id
        @employee_id=MgEmployee.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_user_id=>session[:user_id])
        if curriculum.save
          curriculum.update(:until_date=>date,:mg_employee_id=>@employee_id[0].id)
        end
    redirect_to :action=>"notes" 
end

def notes_update
    @employee_id=MgEmployee.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_user_id=>session[:user_id])
    @curriculum = MgCurriculumNotes.find(params[:id])
    @curriculum.update(notes_update_params)
    @curriculum.update(:mg_wing_id=>params[:mg_wing_id],:mg_unit_id=>params[:mg_unit_id],:mg_topic_id=>params[:mg_topic_id],:mg_subject_id=>params[:mg_subject_id],:mg_course_id=>params[:mg_course_id],:mg_syllabus_id=>params[:mg_syllabus_id])
        timeformat = MgSchool.find(session[:current_user_school_id])
        date = Date.strptime(params[:curriculum][:until_date],timeformat.date_format)
       # assignment.created_by=session[:user_id]batch_subject_id
        if @curriculum.save
          @curriculum.update(:until_date=>date,:mg_employee_id=>@employee_id[0].id)
        end
    redirect_to :action=>"notes" 
end

def attachment_notes_delete
  document=MgCurriculumNotes.find(params[:id])
  document.update(:is_deleted=>1)
  redirect_to :action=>"index"
  #redirect_to :back
end

def notes_delete
    @curriculum=MgCurriculumNotes.find(params[:id])
    @curriculum.update(:is_deleted=>1)
    redirect_to :action=>"document"
end

def notes_edit
    @curriculum=MgCurriculumNotes.find(params[:id])
end



def notes_show
    @curriculum=MgCurriculumNotes.find_by(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:id=>params[:id])    
end


def search
    @employee_id=MgEmployee.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_user_id=>session[:user_id])
    @search=MgCurriculumDocument.where("is_deleted=? and mg_school_id=? and mg_employee_id=?",0,session[:current_user_school_id],@employee_id[0].id)
   
    @employee_id=MgEmployee.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_user_id=>session[:user_id])
    @search_notes=MgCurriculumNotes.where("is_deleted=? and mg_school_id=? and mg_employee_id=?",0,session[:current_user_school_id],@employee_id[0].id)
end

  def curriculum_search_data
   if params[:keywords].present?
    @employee_id=MgEmployee.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_user_id=>session[:user_id])
    @search=MgCurriculumDocument.where("is_deleted=? and mg_school_id=? and mg_employee_id=? and keywords LIKE ?",0,session[:current_user_school_id],@employee_id[0].id,"%#{params[:keywords]}%")
   
    @employee_id=MgEmployee.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_user_id=>session[:user_id])
    @search_notes=MgCurriculumNotes.where("is_deleted=? and mg_school_id=? and mg_employee_id=? and keywords LIKE ?",0,session[:current_user_school_id],@employee_id[0].id,"%#{params[:keywords]}%")

   end
    render :layout=>false

  end

def student_search
  student_batch_id=MgStudent.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_user_id=>session[:user_id]).pluck(:mg_batch_id)
 
  if student_batch_id[0].present?
     @dd=student_batch_id[0]
    courseId=MgBatch.find_by(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:id=>student_batch_id[0])
    if courseId.mg_course_id.present?
      @dd=courseId.mg_course_id
      temp1=Date.today
    @curriculum=MgCurriculumDocument.where("is_sharable=? and until_date>? and is_deleted=? and mg_school_id=? and mg_course_id=?",1,temp1,0,session[:current_user_school_id],courseId.mg_course_id).order(:mg_employee_id).paginate(page: params[:page], per_page: 10)#.paginate(page: params[:page], per_page: 10)
    @curriculum_notes=MgCurriculumNotes.where("is_sharable=? and until_date>? and is_deleted=? and mg_school_id=? and mg_course_id=?",1,temp1,0,session[:current_user_school_id],courseId.mg_course_id).order(:mg_employee_id).paginate(page: params[:page], per_page: 10)
    


   #@search=MgCurriculumDocument.where("is_sharable=? and until_date>? and is_deleted=? and mg_school_id=? and mg_course_id=?",1,temp1,0,session[:current_user_school_id],courseId.mg_course_id)
    

    end
  end
  # CourseId=MgCourse.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_batch_id=>)
  # @curriculum=MgCurriculumDocument.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_employee_id=>@employee_id[0].id)#.paginate(page: params[:page], per_page: 10)
end


def curriculum_student_search_data
    @student=MgStudent.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_user_id=>session[:user_id])
    batch=MgBatch.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:id=>@student[0].mg_batch_id)
    course=MgCourse.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:id=>batch[0].mg_course_id)
    temp1=Date.today
    @search_notes=MgCurriculumNotes.where("is_sharable=? and until_date>? and is_deleted=? and mg_school_id=? and mg_course_id=? and keywords LIKE ?",1,temp1,0,session[:current_user_school_id],course[0].id,"%#{params[:keywords]}%")
    @search=MgCurriculumDocument.where("is_sharable=? and until_date>? and is_deleted=? and mg_school_id=? and mg_course_id=? and keywords LIKE ?",1,temp1,0,session[:current_user_school_id],course[0].id,"%#{params[:keywords]}%")
    render :layout=>false
end


def class_wise_report

end

def subject_wise_report
end

def subject_wise_report_data
  @timetable_id=params[:academic_year]
  @wing_id=params[:prog_id]
  @batch_id=params[:batch_id]
  @subject_id=params[:subject_id]
  @syllabus=MgSyllabusTracker.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_timetable_id=>@timetable_id,:mg_wing_id=>@wing_id,:mg_batch_id=>@batch_id,:mg_subject_id=>@subject_id).pluck(:mg_syllabus_id).uniq
  @syllabus=MgSyllabus.where("is_deleted=? and mg_school_id=? and id IN (?)",0,session[:current_user_school_id],@syllabus)

  render :layout=>false
end



def department_wise_report
end

def department_wise_report_data
  @timetable_id=params[:academic_year]
  @wing_id=params[:prog_id]
  @batch_id=params[:batch_id]
  @subject_id=params[:subject_id]
  @syllabus=MgSyllabusTracker.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_timetable_id=>@timetable_id,:mg_wing_id=>@wing_id,:mg_batch_id=>@batch_id,:mg_subject_id=>@subject_id).pluck(:mg_syllabus_id).uniq
  @syllabus=MgSyllabus.where("is_deleted=? and mg_school_id=? and id IN (?)",0,session[:current_user_school_id],@syllabus)

  render :layout=>false
end

def report
  
end


def report_data
  # @employee=MgEmployee.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_user_id=>session[:user_id])
  # @timetable_id=params[:academic_year]
  # @wing_id=params[:prog_id]
  # @batch_id=params[:batch_id]
  # @subject_id=params[:subject_id]
  # @syllabus=MgSyllabusTracker.where(:mg_employee_id=>@employee[0].id,:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_timetable_id=>@timetable_id,:mg_wing_id=>@wing_id,:mg_batch_id=>@batch_id,:mg_subject_id=>@subject_id).pluck(:mg_syllabus_id).uniq
  # @syllabus=MgSyllabus.where("is_deleted=? and mg_school_id=? and id IN (?)",0,session[:current_user_school_id],@syllabus)



  @employee=MgEmployee.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_user_id=>session[:user_id])
  # @timetable_id=params[:academic_year]
  # @wing_id=params[:prog_id]
  # @batch_id=params[:batch_id]
  # @subject_id=params[:subject_id]
  @syllabus=MgSyllabusTracker.where(:mg_employee_id=>@employee[0].id,:is_deleted=>0,:mg_school_id=>session[:current_user_school_id]).pluck(:mg_syllabus_id).uniq
  @syllabus=MgSyllabus.where("is_deleted=? and mg_school_id=? and id IN (?)",0,session[:current_user_school_id],@syllabus)

  render :layout=>false
end





















# ==============================================================================================

private


  def curr_params_update
     params.require(:curriculum).permit(:mg_curriculum_course_id,:mg_curriculum_grade_id,:mg_wing_id,:mg_timetable_id,:updated_by,:created_by, :name, :description, :is_deleted, :mg_school_id)
   end

   def curr_params
     params.require(:curriculum).permit(:mg_curriculum_course_id,:mg_curriculum_grade_id,:mg_course_id,:mg_wing_id,:mg_timetable_id,:updated_by,:created_by,:mg_subject_id, :name, :description, :is_deleted, :mg_school_id)
   end


   def unit_params
     params.require(:curriculum).permit(:mg_curriculum_grade_id,:mg_subject_id,:mg_course_id,:mg_wing_id,:mg_timetable_id,:mg_syllabus_id, :unit_name, :description, :hour, :min, :is_deleted, :mg_school_id,:created_by,:updated_by)
   end


   def unit_params_update
     params.require(:curriculum).permit(:mg_curriculum_grade_id,:mg_timetable_id, :unit_name, :description, :hour, :min, :is_deleted, :mg_school_id,:updated_by)
   end
   
   def topic_params
     params.require(:curriculum).permit(:mg_timetable_id,:mg_wing_id,:mg_course_id,:mg_subject_id,:mg_curriculum_grade_id,:time_alloted_for_practical,:time_alloted,:mg_unit_id, :mg_syllabus_id, :topic_name, :is_deleted, :mg_school_id,:created_by,:updated_by,:is_project_work)
   end 
   def topics_params
     params.require(:curriculum).permit(:mg_timetable_id,:mg_curriculum_grade_id,:time_alloted_for_practical,:time_alloted, :topic_name, :is_deleted, :mg_school_id,:created_by,:is_project_work)

     #params.require(:curriculum).permit(:time_alloted,:mg_unit_id, :mg_syllabus_id, :topic_name, :description, :is_deleted, :mg_school_id)
   end
   def batchsyllabus_params
     params.require(:curriculum).permit(:mg_batch_id, :mg_subject_id, :topic_name, :is_deleted, :mg_school_id)
   end
   def curric_params
     params.require(:curriculum).permit(:mg_user_id, :mg_subject_id, :mg_topic_id, :is_deleted, :mg_school_id)
    
   end

   def batch_params
     params.require(:curriculum).permit(:mg_batch_id, :mg_syllabus_id, :is_deleted, :mg_school_id)
    
   end

   def batc_params
    params.require(:curriculum).permit(:mg_batch_id, :mg_syllabus_id, :is_deleted, :mg_school_id)
   end

   def params_grade
    params.require(:curriculum).permit(:grade_name,:description,:is_deleted,:mg_school_id,:created_by,:updated_by)
   end

   def params_grade_update
    params.require(:curriculum).permit(:grade_name,:description,:is_deleted,:mg_school_id,:updated_by)
   end

   def params_course
    params.require(:curriculum).permit(:course_name,:description,:is_deleted,:mg_school_id,:created_by,:updated_by)
   end

   def params_course_update
    params.require(:curriculum).permit(:course_name,:description,:is_deleted,:mg_school_id,:updated_by)
   end

   def employee_curriculum_params
     params.require(:curriculum).permit(:mg_timetable_id,:mg_wing_id,:mg_course_id,:mg_subject_id,:mg_curriculum_grade_id,:mg_syllabus_id,:is_deleted,:mg_school_id,:created_by,:updated_by)
     
   end

   def employee_curriculum_update_params
     params.require(:curriculum).permit(:mg_timetable_id,:mg_curriculum_grade_id,:is_deleted,:mg_school_id,:updated_by)
     
   end

   def document_details_params
     params.require(:curriculum).permit(:mg_timetable_id,:mg_wing_id,:mg_course_id,:mg_subject_id,:mg_curriculum_grade_id,:until_date,:mg_unit_id, :mg_syllabus_id, :mg_topic_id, :is_deleted, :mg_school_id,:created_by,:updated_by,:keywords,:is_sharable,:mg_nature_of_document_id)
   end

   def document_update_params
     params.require(:curriculum).permit(:mg_timetable_id,:mg_curriculum_grade_id,:until_date, :is_deleted, :mg_school_id,:keywords,:is_sharable,:mg_nature_of_document_id,:updated_by)
   end

   def notes_details_params
     params.require(:curriculum).permit(:mg_timetable_id,:mg_wing_id,:mg_course_id,:mg_subject_id,:mg_curriculum_grade_id,:until_date,:mg_unit_id, :mg_syllabus_id, :mg_topic_id, :is_deleted, :mg_school_id,:created_by,:updated_by,:keywords,:is_sharable,:note)
   end

   def notes_update_params
     params.require(:curriculum).permit(:mg_timetable_id,:mg_course_id,:mg_subject_id,:mg_curriculum_grade_id,:until_date,:mg_unit_id, :mg_syllabus_id, :mg_topic_id, :is_deleted, :mg_school_id,:updated_by,:keywords,:is_sharable,:note)
     
   end

 end
