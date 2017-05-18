  class ExamManagementController < ApplicationController
	layout "mindcom"
	before_filter :login_required

 def examination_grades_add_new_grade

    puts "Create Here step -hello- 1"
    @grade=MgCollegeGradingLevel.new(grade_params)
    
    
    @grade.save
    @ids=@grade.mg_batch_id
        puts "Create Here step --2"
          puts "new method============"
 redirect_to :action=>'examination_grades', :id=>@ids

  end
def examination_grades

     @bachid=params[:id]

 
          if @bachid!=nil

  @batch=MgBatch.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id]).pluck(:name,:id, :mg_course_id)
  @course_batches=[]
  @batch.each do|b|
 course_batch=[]
course=MgCourse.where(:id=>b[2],:is_deleted=>0,:mg_school_id=>session[:current_user_school_id]).pluck(:course_name)
    @data1=course[0]
    @data2=b[0]
    combineCourseBatch=#{@data1}-#{@data2},#{b[1]}
    puts combineCourseBatch
    course_batch[0]="#{@data1}-#{@data2}"

    course_batch[1]=b[1]

    @course_batches.push(course_batch)

  end
  @grade=MgCollegeGradingLevel.new()

else
logger.info("new method2")
  @batch=MgBatch.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id]).pluck(:name,:id, :mg_course_id)
  @course_batches=[]
  @batch.each do|b|
 course_batch=[]
    course=MgCourse.where(:id=>b[2],:is_deleted=>0,:mg_school_id=>session[:current_user_school_id]).pluck(:course_name)
    @data1=course[0]
    @data2=b[0]
    combineCourseBatch=#{@data1}-#{@data2},#{b[1]}
    puts combineCourseBatch
    course_batch[0]="#{@data1}-#{@data2}"
    course_batch[1]=b[1]
    @course_batches.push(course_batch)

  end
  puts @course_batches.inspect
  @grade=MgCollegeGradingLevel.new()


end

end


def examination_grades_show
   # puts "show method============"
  if params[:mg_batch_id] == ""

    @grades=MgCollegeGradingLevel.where(:mg_batch_id=>nil,:is_deleted=>0,:mg_school_id=>session[:current_user_school_id]).order("min_score  DESC")
    render :json => {:name => @grades }
  else
    #logger.info params[:mg_batch_id]
    logger.info("i am in else condition")
    @grades=MgCollegeGradingLevel.where(:mg_batch_id=>params[:mg_batch_id],:is_deleted=>0,:mg_school_id=>session[:current_user_school_id]).order("min_score DESC")  
    render :json => {:name => @grades }
  end
    #render :layout=>false
end


def examination_grades_add_grades
  #adding to hidden value
  @batchId=params[:batch_id]
  logger.info(@batchId)
  render :layout=>false
  end  



  def examination_grades_edit
    @grades=MgCollegeGradingLevel.find(params[:id])
    @id=@grades.id
    render :layout=>false
  end

  def show_examination_grades
    puts"000000000000000"
    puts params[:id]
    puts"000000000000000"
    @grades=MgCollegeGradingLevel.find_by(:id=>params[:id])
    # @id=@grades.id
    render :layout=>false
  end

  def examination_grades_update
 @grades=MgCollegeGradingLevel.find(params[:id])
@ids=@grades.mg_batch_id
 @grades.update(update_params)
 redirect_to :action=>'examination_grades',:id=>@ids
  end

  def examination_grades_destroy
@grades=MgCollegeGradingLevel.find(params[:id])
@grades.is_deleted =1
@grades.save
@ids=@grades.mg_batch_id

redirect_to :action=>'examination_grades',:id=>@ids
  end
  def examination_fee_schedule
    @fee_collection_list=MgFeeCollection.where(:is_deleted => 0, :mg_school_id=> session[:current_user_school_id],:collection_type=>"examination").paginate(page: params[:page], per_page: 5)
  end

  def examination_delete_fee_schedule
    @fee_fine_schedule=MgFeeCollection.find_by_id(params[:id])
    #@fee_discount.is_deleted =1
    @fee_fine_schedule.update(:is_deleted=>1)
    redirect_to :action=>'examination_fee_schedule'
  end
def exam_fee_category
   
  end
  def exam_fee_category_new
    @feesquery=MgBatch.where(:is_deleted => 0,:mg_school_id=>session[:current_user_school_id]).pluck(:name,:id, :mg_course_id)
  
   render :layout => false
  end
  def exam_fee_category_create
    @selected_batches = params[:selected_batches]
    @feedetails=MgFeeCategory.new(subject_params)
    @feedetails.item_category_name="Examination"
    @feedetails.save
    settings_data=MgSchool.find_by(:is_deleted=>0,:id=>session[:current_user_school_id])
    settings_data.exam_mg_fee_category_id=@feedetails.id
    #loger.infoasdkgh
    settings_data.save
                     @particularData=params[:particulars]
                     
                     for i in 0...@particularData.size
                      @saveParticular=MgParticularType.new()
                      @saveParticular.particular_name=@particularData[i]
                      @saveParticular.mg_fee_category_id=@feedetails.id
                      @saveParticular.is_deleted=0
                      @saveParticular.mg_school_id=session[:current_user_school_id]
                      @saveParticular.save
                     end
   
    redirect_to :action => "exam_fee_category"

  end
  def transport_fee_category_show
     @feeCategory = MgFeeCategory.find(params[:id])
    render :layout => false
  end
def exam_fee_category_edit
 @transport_fees = MgFeeCategory.find(params[:id])
    
    @mg_batch_list=MgBatch.where(:is_deleted => 0, :mg_school_id=> session[:current_user_school_id]).pluck(:name,:id, :mg_course_id) 

    @mg_fee_category_batch_list=MgFeeCategoryBatches.where(:mg_fee_id=>params[:id]).pluck(:mg_batch_id,:id)
    @dueFine=MgParticularType.where(:mg_fee_category_id=>params[:id])
    

    render :layout => false 
end
def exam_fee_category_update
   @feeCategoryObj = MgFeeCategory.find(params[:id])
                 
          @updateparticulars=params[:particulars]
      @particulartypeId=params[:particularstype]
     
                
                
  for i in 0 ... @updateparticulars.size
  @particulartype=MgParticularType.find_by(:mg_fee_category_id=>params[:id],:id=>@particulartypeId[i])                

  if !(@particulartype.nil?)
  @particulartype.update(:particular_name=>@updateparticulars[i])
else
   @particular=MgParticularType.new()
   @particular.particular_name=@updateparticulars[i]
  # puts @updateparticulars[i].inspect
  @particular.mg_fee_category_id=params[:id]
   @particular.is_deleted=0
   @particular.mg_school_id=session[:current_user_school_id]
   puts @particular.inspect
  @particular.save
#logger.infosd
end


end



    
     if @feeCategoryObj.update(subject_params)
       redirect_to :action=>'exam_fee_category'
     else
       render 'exam_fee_category_edit'
     end
  end
  def delete_transport_fee_category
      @fees=MgFeeCategory.find_by_id(params[:id])
    @fees.is_deleted =1
    @fees.save
    @particularType=MgParticularType.where(:mg_fee_category_id=>params[:id])
    @particularType.each do |delete|
      delete.is_deleted=1
      delete.save
    end
    redirect_to :action=>'exam_fee_category'
  end

def manage_exam_particulars

  puts params[:id]
   # puts kashdsaf
    if params[:id].nil? 
        @particular_list=MgFeeParticular.where(:is_deleted => 0,:mg_school_id=>session[:current_user_school_id],:fee_category=>session[:feedetails_id]).paginate(page: params[:page], per_page: 5)
      else
        @particular_list=MgFeeParticular.where(:is_deleted => 0,:mg_school_id=>session[:current_user_school_id],:fee_category=>params[:id]).paginate(page: params[:page], per_page: 5)
        @fee_category=MgFeeCategory.find(params[:id])
        session[:feedetails_id] = @fee_category.id
      end
  end

  def manage_exam_particulars_new
    @subjects=MgFeeParticular.new()
    render :layout => false
  end
 
  def manage_exam_particulars_create
     @selected_batches1 = params[:selected_batches1]
    @params=params[:selectedStudents]
     #using student admission number
      for i in 0...@params.size
        puts"inside if save particular"
        @feeParticularObj=MgFeeParticular.new(particular_params) 
       # @feeParticularObj.mg_particular_type_id=params[:mg_particular_type_id]
        @feeParticularObj.name="Exam Fee"
        @data=MgStudent.find(@params[i])
        @batchID=@data.mg_batch_id
        @feeParticularObj.mg_batch_id=@batchID
        @feeParticularObj.admission_no= @data.admission_number
        save_account_id(params[:fesses2][:selected_account_id],params[:mg_account_id],@feeParticularObj)
        @feeParticularObj.save
        #puts ajsdgjgajd
      end
  
    redirect_to :action=>'manage_exam_particulars',:controller=>'exam_management',:id=>params[:id]
  end

  def save_account_id(selected_account_id,new_account_id,fees_particular_object)
    if selected_account_id.present?
      if selected_account_id=="central"
        fees_particular_object.is_to_central=1
      else
        fees_particular_object.mg_account_id=selected_account_id
      end
    elsif new_account_id.present?
      if new_account_id=="central"
        fees_particular_object.is_to_central=1
      else
        fees_particular_object.mg_account_id=new_account_id
      end
    end
  end
  def exam_edit_fee_particular
    @fesses2 = MgFeeParticular.find(params[:id])
    #   @batches=MgBatch.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id])
    #    @info=Array.new
    #  @batches.each do |b|
    #  @info.push(b.id)
    # end
    @cceID=Array.new
    @cceID.push(@fesses2.mg_batch_id)
    logger.info @fesses2.inspect
    render :layout => false
  end
  def exam_update_fee_particular
    @feeParticularObj = MgFeeParticular.find(params[:id])
    @feeParticularParams = update_particular_params
    @params=params[:selectedStudents]
    if(params[:fesses2][:value1]=='All')
      @feeParticularParams[:admission_no] = ''
      @feeParticularParams[:mg_student_category_id] =''
    end
    if(params[:fesses2][:value1]=='demo')
      @feeParticularParams[:admission_no] =  params[:fesses2][:admission_no] 
      @feeParticularParams[:mg_student_category_id] =''
    end
    if(params[:fesses2][:value1]=='demo2')         
      @feeParticularParams[:admission_no] = ''  
      @feeParticularParams[:mg_student_category_id] =params[:fesses2][:mg_student_category_id]
    end
    @feeParticularObj.update(@feeParticularParams)
    redirect_to :action=>'manage_exam_particulars',:id=>@feeParticularObj.fee_category
  end

  def exam_destroy_fee_particular
    @feesparticular=MgFeeParticular.find(params[:id])
    @feesparticular.is_deleted =1
    @feesparticular.save
    redirect_to :action=>'manage_exam_particulars',:id=>@feesparticular.fee_category
  end

 def student_details_excel_sheet
 render :layout=>false
  
 end
def index_hod_login
    @hod_login=MgUser.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:user_type=>"hod_login").paginate(page: params[:page], per_page: 10)
  end

  def new_hod_login
 render :layout=>false
  end

   def create_hod_login
      school_subdomain= MgSchool.where(:id=>session[:current_user_school_id],:is_deleted=>0)
      @subdomain = school_subdomain[0].subdomain
      @user_name = @subdomain + params[:store_manager][:user_name]

    MgExaminationHodLogin.transaction do
      store_manager=MgUser.new(store_manager_login_params)
      store_manager.user_name=@user_name
      store_manager.save

      role=MgRole.find_by(:role_name=>"hod_login")
      if role.id.present?
        @user_role = store_manager.mg_user_roles.build(:mg_role_id => role.id)
        @user_role.save 
      end
      hod_login_data=MgExaminationHodLogin.new
      hod_login_data.mg_user_id=store_manager.id
      hod_login_data.mg_employee_id=params[:mg_employee_id]
      hod_login_data.mg_employee_specialization_id=params[:mg_employee_specialization_id]
      hod_login_data.is_deleted=0
      hod_login_data.mg_school_id=session[:current_user_school_id]
      hod_login_data.created_by=session[:user_id]
      hod_login_data.updated_by=session[:user_id]
      if hod_login_data.save


        flash[:notice]="Hod created successfully."
      else
        flash[:error]="Hod already created for Specialization."
        @_errors=true
      end
      raise ActiveRecord::Rollback if @_errors
    end
    redirect_to :action=> "index_hod_login"
  end

  def edit_hod_login
    @hod_login=MgUser.find(params[:id])
    render :layout=>false
  end
def update_hod_login
    
    @user_name = params[:subdomain] + params[:store_manager][:user_name]

    user=MgUser.find(params[:store_manager][:id])
    if user.update(:user_name=>@user_name)
      flash[:notice]="Manager updated successfully."
    else
      flash[:error]="Error occured,Please try later."
    end

    if params[:change_store_username]=="change_username_by_admin"
      redirect_to :action=>"index_hod_login"
    elsif params[:change_store_username]=="change_username_by_user"
      redirect_to :action=>"login_information"
    end
  end

  def login_information
    @login_manager=MgExaminationHodLogin.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_user_id=>session[:user_id]).pluck(:mg_employee_specialization_id)
    @login_management=MgEmployeeSpecialization.where("is_deleted=? and mg_school_id=? and id=?",0,session[:current_user_school_id],@login_manager)

  end
  def show_hod_login
    @hod_login=MgUser.find_by(:id=>params[:id])
    render :layout=>false
  end
   def store_manager_change_password
    @store_manager_variable=false
    @fff = params[:store_manager]
    @curr = @fff[:name]
    id=@fff[:user_id]
    user_name = MgUser.where(:id =>id).pluck(:user_name)
    @user=MgUser.where(:id =>id)

    # @bool=@user.authenticate(user_name, @curr)

    # if  @bool==nil
      #flash[:notice] = "Please enter correct password !"
      # store_manager_variable=true
    # else
      @pass = params[:store_manager]
      @passw = @pass[:password]  
      @rpass = params[:store_manager]  
      @rpassw = @rpass[:hashed_password] 
      if @passw==@rpassw
        if @user
          @userMe=MgUser.find(id)
          @userMe.update(store_manager_password_params)
        end  
      else
        flash[:notice] = "Re Entered password didn't matched !"
      end
    # end
  
    if @store_manager_variable==true
      flash[:notice] = "Invalid Password..."
    else
      flash[:notice] = "Password Change Successfully..."
    end

    if params[:change_store_password]=="change_password_by_admin"
      redirect_to :action => "index_hod_login"
    elsif params[:change_store_password]=="change_password_by_user"
      redirect_to :action => "login_information"
    end
  end

  def delete_hod_login
    
    MgUser.transaction do
      mg_user=MgUser.find_by(:id=>params[:id])
      mg_user.update(:is_deleted=>1)
      store_manager=MgExaminationHodLogin.find_by(:mg_user_id=>params[:id])
      store_manager.update(:is_deleted=>1)
    end
    redirect_to :action=> "index_hod_login"
  end
  def generate_exam_report

  end

  def report_generation_for_student_data

    @student_id=params[:id]
    @detail_id=params[:exam_type]
    @batch_id=params[:batch_id]


  @student_data=MgExaminationStudentMarks.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_student_id=>params[:id])
render :layout=>false

end

def generate_report_pdf

  data=params[:id]
  individual_id=data.split("-")
school_data=session[:current_user_school_id]
  #logger.info asjdga
school=MgSchool.find(session[:current_user_school_id])
 school_logo=school.logo.url(:medium,:timestamp=>false)
student=MgStudent.find(individual_id[0])
@@photo=student.avatar.url(:medium,:timestamp=>false)
batch_data=MgBatch.find_by(:id=>student.mg_batch_id)
@@subject_data=MgSubject.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_course_id=>batch_data.mg_course_id)
    pdf = Prawn::Document.new do

                  repeat :all do


                    # header
                       bounding_box [bounds.left, bounds.top],:align => :right, :width  => bounds.width do
                          font "Helvetica"
                          if File.exists?("#{Rails.root}/public/#{school_logo}") 
                            image( "#{Rails.root}/public/#{school_logo}", :at => [0,20],:width =>  45)
                             #image( "#{Rails.root}/public/#{school_logo}",:width =>  45)
                            # image ("#{Rails.root}/public/#{@@school_logo}"),:at=>[425,690],:width=>45
                            # image "#{Rails.root}/public/#{@@school_logo}", :width => 45, :align => :left
                          
                           end
                           move_up 15
                  text_box(school.school_name,:align => :left,:at=>[50,10],:left_margin => 100, :size => 16,:width => 400)
                           move_down 44

                          #text school.school_name, :align => :center, :size => 18
                          stroke_horizontal_rule
                         end
        move_down 10
 bounding_box [bounds.left, bounds.bottom + 5], :width  => bounds.width do
                            font "Helvetica"
              stroke_horizontal_rule
              move_down(5)
              # image "#{Rails.root}/app/assets/images/mindcom-logo.png", :width => 45, :align => :left
              # text " Powered By - ©", :size => 12
              move_down 10
              # draw_text "Terms & Conditions| Privacy Policy| About Us| Contact Us",:at => [70,3]
              draw_text "Powered By - ©", :at => [400,3]
              image "#{Rails.root}/app/assets/images/mindcom-logo.png", :at=>[495,15], :width => 45, :align => :right
                        end
  end
  bounding_box([bounds.left, bounds.top - 60], :width  => bounds.width, :height => bounds.height - 55) do
           if File.exists?("#{Rails.root}/public/#{@@photo}")
        #image ("#{Rails.root}/public/#{@@photo}"),:at=>[425,650],:width=>45
    end
        move_down 15      
        draw_text "Name: #{student.first_name} #{student.last_name}",:at => [0,660]  
       draw_text "Roll Number: #{student.admission_number}", :at => [350,660]  
        
        move_down 5                  #move_down 25
        #widths=[56,188,188,92]
widths=[98,66,66,56,56]

        # widths = [35,35,35,35]
        cell_height = 8
        font_size=8
detail_data=MgExaminationDetail.find_by(:id=>individual_id[1])
        exam_type=MgExamType.find_by(:id=>detail_data.mg_exam_type_id)
        table([["" ,exam_type.name]], :column_widths => [98,244], :cell_style => { size: font_size,:align => :center })
            table([["Subjects","Max Marks", "Marks Obtained","Remarks","Grade"]], :column_widths => widths, :cell_style => { size: font_size })
@i=0

            @@subject_data.each do |sub|
      #table([[sub[0],"Highest", "lowest","Average"]], :column_widths => widths, :cell_style => { size: font_size })
 @subject=MgSubject.find(sub.id)
      
data=MgExaminationStudentMarks.where(:mg_student_id=>individual_id[0],:is_deleted=>0,:mg_school_id=>school_data).pluck(:mg_examination_marks_evaluation_data_id).uniq
marks_data_validation=MgExaminationMarksEvaluationData.where(:is_deleted=>0,:mg_school_id=>school_data,:id=>data).pluck(:mg_examination_detail_id).uniq
marks_data=MgExaminationMarksEvaluationData.where(:mg_examination_detail_id=>individual_id[1],:is_deleted=>0,:mg_school_id=>school_data,:mg_course_id=>batch_data.mg_course_id).pluck(:mg_subject_id).uniq
examination_evaluation_data=MgExaminationMarksEvaluationData.where(:mg_examination_detail_id=>individual_id[1],:is_deleted=>0,:mg_school_id=>school_data,:mg_course_id=>batch_data.mg_course_id).pluck(:id)
    
 
if marks_data.include?sub.id

  time_table_data=MgExaminationTimeTable.find_by(:is_deleted=>0,:mg_school_id=>school_data,:mg_examination_detail_id=>individual_id[1],:mg_subject_id=>sub.id,:mg_batch_id=>individual_id[2])
  data= examination_evaluation_data[@i]
  student_marks=MgExaminationStudentMarks.find_by(:is_deleted=>0,:mg_school_id=>school_data,:mg_student_id=>individual_id[0],:mg_examination_marks_evaluation_data_id=>data)
#table([[@subject.subject_name,exam_score_max.present? ? exam_score_max : '-', exam_score_min.present? ? exam_score_min : '-',exam_group.subject_wise_batch_average_marks(@subjectsId.id).present? ? exam_group.subject_wise_batch_average_marks(@subjectsId.id) : '-']], :column_widths => widths, :cell_style => { size: font_size })
@gradeLevelArray = MgCollegeGradingLevel.where(:is_deleted=>0,:mg_school_id=>school_data).order('min_score DESC')

  @gradeLevelArray.each do |gradeObj|
      if student_marks.marks_obtained > gradeObj.min_score
        @gradeLevel = gradeObj.name

       puts student_marks.marks_obtained.to_i.inspect
       puts gradeObj.min_score.to_i.inspect


        break
      end
end
table([[@subject.subject_name,if time_table_data.nil? then "Not Defined" else time_table_data.max_marks end, student_marks.marks_obtained ,if time_table_data.nil? then "Not Defined" elsif student_marks.marks_obtained>time_table_data.pass_marks then "P" else "F" end,if @gradeLevel!=nil then @gradeLevel else "-" end]], :column_widths => widths, :cell_style => { size: font_size })
@gradeLevel=nil
@i=@i+1
else
table([[@subject.subject_name,"-","-","-","-"]], :column_widths => widths, :cell_style => { size: font_size })

end


end
move_down(10)
 table([["P","Pass", "F","Fail"]], :column_widths => widths, :cell_style => { size: font_size })

end   
            

end 


   send_data pdf.render,   :info => {
                      :Title => "My title",
                      :Author => "John Doe",
                      :Subject => "My Subject",
                      :Keywords => "test metadata ruby pdf dry",
                      :Creator => "ACME Soft App",
                      :Producer => "Prawn",
                      :CreationDate => Time.now
                      }, :filename => "x.pdf", :type => "application/pdf", :disposition => 'inline'
                      


end
	def examination_details_for_program
  puts "asdfsafsfd"
  puts params[:id].inspect
time_table_data=MgExaminationTimeTable.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_examination_detail_id=>params[:id]).pluck(:mg_wing_id).uniq
  puts "asdfsafsfdadasdd"

puts time_table_data.inspect
@wing_data=MgWing.where(:id=>time_table_data).pluck(:wing_name,:id)
render :layout=>false
end

def examination_details_for_course
  @course_data=MgCourse.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_wing_id=>params[:id]).pluck(:course_name,:id)
render :layout=>false

end
def examination_details_for_course_evaluation
  @course_data=MgCourse.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_wing_id=>params[:id]).pluck(:course_name,:id)
render :layout=>false

end

def examination_details_for_subject
@subject_data=MgSubject.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_course_id=>params[:id]).pluck(:subject_name,:id)
render :layout=>false
end

def examination_marks_details_for_subject
  @timetable_data=MgExaminationTimeTable.find_by(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_subject_id=>params[:s_id],:mg_examination_detail_id=>params[:exam_id])

@subject_data=MgSubject.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_course_id=>params[:id]).pluck(:subject_name,:id)
@batch_data=MgBatch.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_course_id=>params[:id]).pluck(:id)
@student_data=MgStudent.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_batch_id=>@batch_data)
render :layout=>false
end
def examination_marks_entry_for_subject_marks
  @timetable_data=MgSubject.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_course_id=>params[:id]).pluck(:subject_name,:id)

  #@timetable_data=MgExaminationTimeTable.find_by(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_subject_id=>params[:id],:mg_examination_detail_id=>params[:exam_id])
   render :layout=>false

end
def examination_marks_entry_for_subject_marks_evaluation
@timetable_data=MgSubject.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_course_id=>params[:id]).pluck(:subject_name,:id)

  #@timetable_data=MgExaminationTimeTable.find_by(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_subject_id=>params[:id],:mg_examination_detail_id=>params[:exam_id])
   render :layout=>false
  end
def examination_marks_entry_create
 
marks_data=MgExaminationMarksEvaluationData.new()
marks_data.mg_examination_detail_id=params[:mg_examination_detail_id]
marks_data.mg_wing_id=params[:mg_examination_wing_id]["0"]
marks_data.mg_course_id=params[:mg_course_id][0]
marks_data.mg_subject_id=params[:mg_subject_id]
marks_data.max_marks=params[:marks_data]
timeformat = MgSchool.find(session[:current_user_school_id])
evaluation_date = Date.strptime(params[:examination_evaluation_details_data][:date_of_evaluation],timeformat.date_format)
marks_data.date_of_marks_entry=evaluation_date
marks_data.is_deleted=0
marks_data.mg_school_id=session[:current_user_school_id]
marks_data.created_by=session[:user_id]
marks_data.updated_by=session[:user_id]
marks_data.save

student_marks=params[:marks_obtained]
student_ids=params[:student_id]
#grades_ids=params[:grades_id]
 for j in 0...student_ids.size


student_data= MgExaminationStudentMarks.new()
student_data.mg_examination_marks_evaluation_data_id=marks_data.id
student_data.mg_student_id=student_ids[j]
#student_data.mg_grading_level_id=grades_ids[j]
student_data.marks_obtained=params[:marks_obtained][student_ids[j]]
student_data.is_deleted=0
student_data.mg_school_id=session[:current_user_school_id]
student_data.created_by=session[:user_id]
student_data.updated_by=session[:user_id]
student_data.save

end
redirect_to :action=>"examination_marks_sheet_details"
end

def issue_exam_application
     @application_form_data=MgExamApplicationFormData.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id])
end

def issue_exam_application_new

    @time_table_data=MgTimeTable.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id]).pluck(:name,:id)
    @wing_data=MgWing.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id]).pluck(:wing_name,:id)

end

def select_student_for_report
@student_data=MgStudent.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_batch_id=>params[:id]).pluck(:first_name,:id)
render :layout=>false
end
def issue_exam_application_show
    @data=MgExamApplicationFormData.find_by(:id=>params[:id])

end
def issue_exam_application_edit
    @wing_data=MgWing.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id]).pluck(:wing_name,:id)

    @exam_application_form=MgExamApplicationFormData.find_by(:id=>params[:id])

end
def select_class_based_on_wing
     @school_id =  session[:current_user_school_id]
     course_data=MgCourse.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_wing_id=>params[:id]).pluck(:id)
     @batches = MgBatch.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_course_id=>course_data)
     render :layout=>false
end


def select_students
    
      @student_hash_list=MgStudent.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_batch_id=>params[:id])
     if @student_hash_list.length>0
       
      @student_hash=Array.new
      @student_hash_list.each do|list|
      list_ary=Array.new()
      first_name=list.first_name
      key="#{first_name} "
      value=list.id
      list_ary.push(key,value)
      @student_hash.push(list_ary)
    end
  end
      render :layout=>false
   
end
def select_students_edit
   
      @selected_students_data=ExamApplicationFormStudent.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_exam_application_form_data_id=>params[:data]).pluck(:mg_student_id)

      @selected_students=MgStudent.where(:id=>@selected_students_data).pluck(:first_name,:id)
      @student_hash_data=MgStudent.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_batch_id=>params[:id])
      

   @student_hash=Array.new
      @student_hash_data.each do|list|
      list_ary=Array.new()
      first_name=list.first_name
      key="#{first_name} "
      value=list.id
      list_ary.push(key,value)
      @student_hash.push(list_ary)
    end
    render :layout=>false
end
def issue_exam_application_update
  #puts params.inspect

  
  @params=params[:ids]
  particulars=params[:particular]
  amount=params[:amount]
  amount_data=params[:total_amount]
  
school_id=session[:current_user_school_id]

# @timeformat = MgSchool.find(school_id)
# date_of_evaluation = Date.strptime(params[:evaluation_date],@timeformat.date_format)
  @application_details=MgExamApplicationFormData.find_by(:id=>params[:id])
  @application_details.update(:total_amount=>amount_data)
  examination_evaluation_data=ExamApplicationFormStudent.where('is_deleted=? and mg_school_id=? and mg_exam_application_form_data_id=? and id  NOT IN (?)', 0,session[:current_user_school_id],params[:id],params[:ids])
if examination_evaluation_data.length>0
  for j in 0...examination_evaluation_data.length 
   data=ExamApplicationFormStudent.find_by(:id=>examination_evaluation_data[j].id)
   if data.present?
  data.update(:is_deleted=>1)
end
end
 end
@params=params[:ids]
puts @params.inspect
 #if @params.present?
for j in 0...@params.size

 inventory_data=ExamApplicationFormStudent.where('mg_school_id=? and mg_exam_application_form_data_id=? and id=?', session[:current_user_school_id],params[:id],@params[j])
 if inventory_data.size<1
  if amount[j].present?&&particulars[j].present?

    #puts adsad
    purchase_details=ExamApplicationFormStudent.new()
    purchase_details.mg_exam_application_form_data_id=params[:id]
    purchase_details.student_particulars=particulars[j]
    purchase_details.amount=amount[j]

    purchase_details.is_deleted=0
    purchase_details.mg_school_id=session[:current_user_school_id]
    purchase_details.created_by=session[:user_id]
    purchase_details.updated_by=session[:user_id]
   
    purchase_details.save
  else
end
else
  inventory_data[0].update(:student_particulars=>particulars[j],:amount=>amount[j])
end
end
puts params[:studentids].inspect
puts params[:studentidsdata].inspect
puts params[:form_data].inspect

  @params12=params[:studentids]
  form=params[:form_data]
  student=params[:studentidsdata]
# logger.info asdasd
  evaluation_data=MgExamApplicationStudentReceipt.where('is_deleted=? and mg_school_id=? and mg_exam_application_form_data_id=? and mg_student_id  NOT IN (?)', 0,session[:current_user_school_id],params[:id],params[:studentidsdata])
puts evaluation_data
#logger.info asdasd
if evaluation_data.length>0
  for j in 0...evaluation_data.length 
   data=MgExamApplicationStudentReceipt.find_by(:id=>evaluation_data[j].id)
   if data.present?
  data.update(:is_deleted=>1)
end
end
 end
 for j in 0...student.size

 inventory_data=MgExamApplicationStudentReceipt.where('mg_school_id=? and mg_student_id=? and mg_exam_application_form_data_id=?', session[:current_user_school_id],student[j],params[:id])
 if inventory_data.size<1
  if student[j].present?

    #puts adsad
    purchase_details=MgExamApplicationStudentReceipt.new()
    purchase_details.mg_exam_application_form_data_id=params[:id]
    purchase_details.mg_student_id=student[j]
    purchase_details.form_no=form[j]

    purchase_details.is_deleted=0
    purchase_details.mg_school_id=session[:current_user_school_id]
    purchase_details.created_by=session[:user_id]
    purchase_details.updated_by=session[:user_id]
   
    purchase_details.save
  else
end
else
  inventory_data[0].update(:mg_student_id=>student[j],:form_no=>form[j])
end
end
#end
  flash[:notice]="Data has Updated"
  redirect_to :action=>'issue_exam_application'
#@examination_evaluation_details_data=MgExaminationEvaluation.find_by(:id=>params[:id])
# @params=params[:ExaminationSelectedStudentsedit]


#  puts @params.inspect
#  #logger.infoJHDG

#   school_id=session[:current_user_school_id]
#  for j in 0...@params.size

#    application_data=ExamApplicationFormStudent.where('mg_school_id=? and  mg_student_id=? and mg_exam_application_form_data_id=?', school_id,@params[j],params[:id])

#  if application_data.size<1

#     @data=ExamApplicationFormStudent.new()
#     @data.is_deleted=0
#     @data.created_by=session[:user_id]
#     @data.updated_by=session[:user_id]
#     @data.mg_student_id=@params[j]
#     @data.mg_school_id=school_id
#     @data.mg_exam_application_form_data_id=params[:id]
#     @data.save
#   else
#         application_data[0].update(:is_deleted=>0,:mg_school_id=>school_id)
        
#       end
      
#     end

#   application_data=ExamApplicationFormStudent.where('is_deleted=? and mg_school_id=? and  mg_student_id  NOT IN (?) and mg_exam_application_form_data_id=?', 0,school_id,params[:ExaminationSelectedStudentsedit],params[:id])
#   #     puts application_data.inspect 

#  if application_data.length>0
#     for j in 0...application_data.length
     
#      data=ExamApplicationFormStudent.find_by(:id=>application_data[j].id)
#      if data.present?
#     data.update(:is_deleted=>1)
#    end
#   end
#    end
# redirect_to :action=>"issue_exam_application"

end

def issue_exam_application_destroy

application_data=MgExamApplicationFormData.find_by(:id=>params[:id])
application_data.is_deleted=1
application_data.save
redirect_to :action=>"issue_exam_application"

  end
def issue_exam_application_create
 
puts params[:form_field_data].inspect
#puts params[:form_field_data][1].inspect
#puts params[:form_field_data][2].inspect

puts params[:tag_data][0].inspect
#logger.info alJLASLJLFJLLSFDS
timeformat = MgSchool.find(session[:current_user_school_id])
due_date = Date.strptime(params[:exam_application_form][:due_date],timeformat.date_format)
#logger.info askdbhkjas
student_array=params[:particular]
amount=params[:amount]
school_data=session[:current_user_school_id]
application_data=MgExamApplicationFormData.new()
application_data.mg_examination_detail_id=params[:mg_examination_detail_id]
application_data.mg_wing_id=params[:mg_examination_wing_id]["0"]
application_data.due_date=due_date
application_data.mg_batch_id=params[:mg_batch_id]
application_data.mg_student_id=params[:selectedStudentsId]
application_data.total_amount=params[:total_amount]
application_data.receipt_number=params[:receipt_no]

application_data.is_deleted=0
application_data.mg_school_id=school_data
application_data.created_by=session[:user_id]
application_data.updated_by=session[:user_id]

application_data.save

#  params[:particular].each do |key,i|
# puts "khydsakhdkhaskhdkkhskhdkahkshdkhkasd79797997"
#  puts params[:particular][key].inspect
#  puts params[:amount][key].to_i.inspect
# #puts ajlsldkjakljd

#  end
# puts ajlsldkjakljd

params[:particular].each do |key,i|

  
application_form=ExamApplicationFormStudent.new()
application_form.mg_exam_application_form_data_id=application_data.id
application_form.student_particulars=params[:particular][key]
application_form.amount=params[:amount][key]
application_form.is_deleted=0
application_form.mg_school_id=session[:current_user_school_id]
application_form.created_by=session[:user_id]
application_form.updated_by=session[:user_id]
application_form.save
end

params[:tag_data].each_with_index do |key,i|
receipt_data=MgExamApplicationStudentReceipt.new()
receipt_data.mg_exam_application_form_data_id=application_data.id
receipt_data.form_no=params[:form_field_data][key]
receipt_data.mg_student_id=params[:tag_data][i].to_i
receipt_data.is_deleted=0
receipt_data.mg_school_id=session[:current_user_school_id]
receipt_data.created_by=session[:user_id]
receipt_data.updated_by=session[:user_id]
receipt_data.save
end
# else
# flash[:notice]="Uniqeness of Exam and Semester should be maintained"

# end
redirect_to :action=>"issue_exam_application"
end



def Examination_evaluation_data
@evaluation_data=MgExaminationEvaluation.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id])
end
def examination_evaluation__new

end
def examination_evaluation_create
 
  examination_detail_id=params[:mg_examination_detail_id]
  examiner_name=params[:name]
  examination_wing_data=params[:mg_examination_wing_id]
  course_data=params[:mg_course_id]
  subject_data=params[:mg_subject_id]
college_name=params[:college_name]
copies_data=params[:copies]
evaluation_data=MgExaminationEvaluation.new
evaluation_data.mg_examination_detail_id=examination_detail_id
timeformat = MgSchool.find(session[:current_user_school_id])
evaluation_date = Date.strptime(params[:examination_evaluation_details_data][:date_of_evaluation],timeformat.date_format)
evaluation_data.date_of_evaluation=evaluation_date

evaluation_data.is_deleted=0
evaluation_data.created_by=session[:user_id]
evaluation_data.updated_by=session[:user_id]
evaluation_data.mg_school_id=session[:current_user_school_id]
evaluation_data.save
 params[:name].each do |key,i|

examination_evaluation_data=MgExaminationEvaluationData.new()
examination_evaluation_data.mg_examination_evaluation_id=evaluation_data.id
examination_evaluation_data.examiner_name=params[:name][key]
examination_evaluation_data.mg_wing_id=params[:mg_examination_wing_id][key]
examination_evaluation_data.mg_course_id=params[:mg_course_id][key]
examination_evaluation_data.mg_subject_id=params[:mg_subject_id][key]
examination_evaluation_data.college_name_data=params[:college_name][key]
examination_evaluation_data.copies=params[:copies][key]
examination_evaluation_data.is_deleted=0
examination_evaluation_data.mg_school_id=session[:current_user_school_id]
examination_evaluation_data.save

end
redirect_to :action=>'Examination_evaluation_data'
end
def exam_evaluation_data_show
  @evaluation_data=MgExaminationEvaluation.find_by(:id=>params[:id])
 @examination_evaluation_data=MgExaminationEvaluationData.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_examination_evaluation_id=>params[:id])
end
def exam_evaluation_data_edit
@evaluation_data=MgExaminationEvaluation.find_by(:id=>params[:id])
 @examination_evaluation_data=MgExaminationEvaluationData.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_examination_evaluation_id=>params[:id])
  end

def exam_evaluation_data_update

  puts params.inspect
  @params=params[:ids]

 puts @params.inspect

 puts "dljflksdkljfldfdfsdfdfff"


#puts @params.inspect
  #puts hasdhd



  examiner_name=params[:name]
  examination_wing_data=params[:mg_examination_wing_id]
  course_data=params[:mg_course_id]
  subject_data=params[:mg_subject_id]
college_name=params[:college_name]
copies_data=params[:copies]
school_id=session[:current_user_school_id]

@timeformat = MgSchool.find(school_id)
date_of_evaluation = Date.strptime(params[:evaluation_date],@timeformat.date_format)


  @evaluation_details=MgExaminationEvaluation.find_by(:id=>params[:id])
  @evaluation_details.update(:date_of_evaluation=>date_of_evaluation)


arry=Array.new()
 params[:ids].each do |key,i|

arry.push(params[:ids][key])

 end
  examination_evaluation_data=MgExaminationEvaluationData.where('is_deleted=? and mg_school_id=? and mg_examination_evaluation_id=? and id  NOT IN (?)', 0,session[:current_user_school_id],params[:id],arry)
if examination_evaluation_data.length>0
  for j in 0...examination_evaluation_data.length 
   data=MgExaminationEvaluationData.find_by(:id=>examination_evaluation_data[j].id)
   if data.present?
  data.update(:is_deleted=>1)
end
end
 end
@params=params[:ids]
puts @params.inspect
 #if @params.present?
#for j in 0...@params.size
 params[:name].each do |key,i|

 inventory_data=MgExaminationEvaluationData.where('mg_school_id=? and mg_examination_evaluation_id=? and id=?', session[:current_user_school_id],params[:id],params[:ids][key])
 puts inventory_data.inspect
 if inventory_data.size<1
    #puts adsad
    purchase_details=MgExaminationEvaluationData.new()
    purchase_details.mg_examination_evaluation_id=params[:id]
    purchase_details.mg_wing_id=params[:mg_examination_wing_id][key]
    purchase_details.examiner_name=params[:name][key]
    purchase_details.mg_course_id=params[:mg_course_id][key]
    purchase_details.mg_subject_id=params[:mg_subject_id][key]
     purchase_details.college_name_data=params[:college_name][key]
    
    purchase_details.copies=params[:copies][key]
    purchase_details.is_deleted=0
    purchase_details.mg_school_id=session[:current_user_school_id]
    purchase_details.created_by=session[:user_id]
    purchase_details.updated_by=session[:user_id]
   
    purchase_details.save
 #puts ajsdgfdasf
else
  inventory_data[0].update(:examiner_name=>params[:name][key],:mg_wing_id=>params[:mg_examination_wing_id][key],:mg_course_id=>params[:mg_course_id][key],:mg_subject_id=>params[:mg_subject_id][key],:college_name_data=>params[:college_name][key],:copies=>params[:copies][key])
end


end
#end
  flash[:notice]="Data has Updated"
  redirect_to :action=>'Examination_evaluation_data'
#@examination_evaluation_details_data=MgExaminationEvaluation.find_by(:id=>params[:id])

end

  def exam_evaluation_data_destroy
  @evaluation_details=MgExaminationEvaluation.find_by(:id=>params[:id])
  @evaluation_details.is_deleted=1
  @evaluation_details.save
  redirect_to :action=>'Examination_evaluation_data'
  
  end

  def examination_marks_sheet_details
  @marks_evaluation_data=MgExaminationMarksEvaluationData.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id])

  end
def examination_marks_sheet_details_show
@marks_data_show=MgExaminationMarksEvaluationData.find_by(:id=>params[:id])
@student_marks_data=MgExaminationStudentMarks.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_examination_marks_evaluation_data_id=>params[:id])
end
def examination_marks_sheet_details_edit
@marks_data_edit=MgExaminationMarksEvaluationData.find_by(:id=>params[:id])
@student_marks_data=MgExaminationStudentMarks.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_examination_marks_evaluation_data_id=>params[:id])
end

def examination_marks_entry_update


evaluation_data=MgExaminationMarksEvaluationData.find_by(:id=>params[:id])
@timeformat = MgSchool.find_by(:id=>session[:current_user_school_id])
date_of_evaluation = Date.strptime(params[:examination_evaluation_details_data][:date_of_evaluation],@timeformat.date_format)

evaluation_data.update(:date_of_marks_entry=>date_of_evaluation)
student_ids=params[:student_id]
orginal_data=params[:orginal_id]
student_marks=params[:marks_obtained]
#grades_ids=params[:grades_id]
 for j in 0...orginal_data.size


student_data=MgExaminationStudentMarks.find_by(:id=>orginal_data[j])

#student_data.mg_grading_level_id=grades_ids[j]
student_data.marks_obtained=params[:marks_obtained][student_ids[j]]
student_data.created_by=session[:user_id]
student_data.updated_by=session[:user_id]
student_data.save

end
redirect_to :action=>"examination_marks_sheet_details"
end

def examination_marks_entry_destroy
  marks_evaluation_data=MgExaminationMarksEvaluationData.find_by(:id=>params[:id])
  marks_evaluation_data.is_deleted=1
  marks_evaluation_data.save
redirect_to :action=>"examination_marks_sheet_details"
  end
  def examination_marks_sheet_details_new

  end
	  def program_category_data
	  @program_category_data=MgExaminationProgramCategory.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id]) 
	  end
	  def program_category_data_new
	  render :layout=>false
	  end
	  def program_category_create
	  @program_category_data=MgExaminationProgramCategory.new(exam_management_program_category)
	  @program_category_data.is_deleted=0
	  @program_category_data.mg_school_id=session[:current_user_school_id]
	  @program_category_data.created_by=session[:user_id]
	  @program_category_data.updated_by=session[:user_id]
	  @program_category_data.save
	  redirect_to :action=>'program_category_data'
	  end
	  def program_category_edit
	  @exam_management_data=MgExaminationProgramCategory.find_by(:id=>params[:id]) 
	  render :layout=>false
	  end

	  def program_category_update
	  exam_management_data=MgExaminationProgramCategory.find_by(:id=>params[:id]) 
	  exam_management_data.update(exam_management_program_category)
	  redirect_to :action=>'program_category_data'
	  end

	  def program_category_destroy
	  exam_management_data=MgExaminationProgramCategory.find_by(:id=>params[:id]) 
	  exam_management_data.is_deleted=1
	  exam_management_data.save
	  redirect_to :action=>'program_category_data'
	  end

	  def controller_examiner_show
    @financial_manager=MgUser.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:user_type=>"examination_controller")

	  end

	  def assaign_exam_management_new

	   
	  render :layout=>false

	  end
 def unique_username
    school_subdomain= MgSchool.where(:id=>session[:current_user_school_id],:is_deleted=>0)
    @subdomain = school_subdomain[0].subdomain
    @user_name = @subdomain + params[:user_name]
    @user_validate = MgUser.where("is_deleted=? and mg_school_id=? and user_name=?",0,session[:current_user_school_id],@user_name)
    if @user_validate.present?
      @data=1
    else
      @data=0
    end
    respond_to do |format|
      format.json  { render :json => @data.to_json }
    end
  end
	  def assaign_exam_controller_create
	 # exam_controller_data=MgExamController.new
	 # exam_controller_data.mg_employee_id=params[:mg_employee_id]
	 # exam_controller_data.mg_employee_department_id=params[:mg_employee_department_id]
	 # exam_controller_data.is_deleted=0
	 # exam_controller_data.mg_school_id=session[:current_user_school_id]
	 # exam_controller_data.created_by=session[:user_id]
	 # exam_controller_data.updated_by=session[:user_id]
	 # exam_controller_data.save
	 # redirect_to :action=>'controller_examiner_show'
   school_subdomain= MgSchool.where(:id=>session[:current_user_school_id],:is_deleted=>0)
    @subdomain = school_subdomain[0].subdomain
    @user_name = @subdomain + params[:financial_manager][:user_name]
    @user_role_save=[]
    MgUser.transaction do

      financial_manager=MgUser.new(params_user)
      financial_manager.user_name=@user_name
      financial_manager.save
      role=MgRole.find_by(:role_name=>"examination_controller")
      if role.id.present?
        @user_role = financial_manager.mg_user_roles.build(:mg_role_id => role.id)
        @user_role_save.push(@user_role.save)
      end
      if @user_role_save.include?(false) #add
        raise ActiveRecord::Rollback #add
      end
    end
    if @user_role_save.include?(false) #add
      flash[:error] = "There is some problem" #add
    else #add
      flash[:notice] = "Examination Controller Created Successfully" #add
    end 
    redirect_to :action=> "controller_examiner_show"
	 end
   def change_hod_login_password
    @boolean_val=false
    @fff = params[:financial_manager]
    @curr = @fff[:name]
    id=@fff[:user_id]
    user_name = MgUser.where(:id =>id).pluck(:user_name)
    @user=MgUser.where(:id =>id)

    # @bool=@user.authenticate(user_name, @curr)

    
    # if  @bool==nil
      # flash[:notice] = "Please enter correct password !"
      # @boolean_val=true
    # else
      @pass = params[:financial_manager]
      @passw = @pass[:password]  #new pass
      @rpass = params[:financial_manager]  
      @rpassw = @rpass[:hashed_password] #confirm pass
      if @passw==@rpassw
        if @user
          @userMe=MgUser.find(id)
          @userMe.update(password_params)
        end  
      else
        flash[:notice] = "Re Entered password didn't matched !"
      end
    # end
    
    if @boolean_val==true
      flash[:notice] = "Invalid Password..."
      #redirect_to :action => "index_financial_officer"
    else
      flash[:notice] = "Password Change Successfully..."
      #redirect_to :action => "index_financial_officer"
    end
    if params[:change_financial_password]=="change_password_by_admins"
      redirect_to :action => "controller_examiner_show"
    elsif params[:change_financial_password]=="change_password_by_manager"
      redirect_to :action => "change_credential"
    end

  end
  def change_credential
    @examination_controller=MgUser.where(:is_deleted=>0,:id=>session[:user_id],:mg_school_id=>session[:current_user_school_id],:user_type=>"examination_controller")
  end
	 def assaign_exam_management_edit
	 # @controller_officer=MgExamController.find_by(:id=>params[:id])
	 # render :layout=>false

    @financial_manager=MgUser.find_by(:id=>params[:id])
    render :layout=>false
 
	 end
# def change_financial_password

#     @boolean_val=false
#     @fff = params[:financial_manager]
#     @curr = @fff[:name]
#     id=@fff[:user_id]
#     user_name = MgUser.where(:id =>id).pluck(:user_name)
#     @user=MgUser.where(:id =>id)

#     @bool=@user.authenticate(user_name, @curr)

    
#     if  @bool==nil
#       # flash[:notice] = "Please enter correct password !"
#       @boolean_val=true
#     else
#       @pass = params[:financial_manager]
#       @passw = @pass[:password]  #new pass
#       @rpass = params[:financial_manager]  
#       @rpassw = @rpass[:hashed_password] #confirm pass
#       if @passw==@rpassw
#         if @user
#           @userMe=MgUser.find(id)
#           @userMe.update(password_params)
#         end  
#       else
#         flash[:notice] = "Re Entered password didn't matched !"
#       end
#     end
    
#     if @boolean_val==true
#       flash[:notice] = "Invalid Password..."
#       #redirect_to :action => "index_financial_officer"
#     else
#       flash[:notice] = "Password Change Successfully..."
#       #redirect_to :action => "index_financial_officer"
#     end
#     if params[:change_financial_password]=="change_password_by_admins"
#       redirect_to :action => "index_financial_officer"
#     elsif params[:change_financial_password]=="change_password_by_manager"
#       redirect_to :action => "change_credential"
#     end

#   end
	 def assaign_exam_management_update
	 # controller_officer=MgExamController.find_by(:id=>params[:id])
	 # controller_officer.update(:mg_employee_department_id=>params[:mg_employee_department_id],:mg_employee_id=>params[:mg_employee_id])
	 # redirect_to :action=>'controller_examiner_show'
    @user_name = params[:subdomain] + params[:financial_manager][:user_name]
    financial_manager=MgUser.find_by(:id=>params[:financial_manager][:id])
    #financial_manager.update(params_user_update)

    if financial_manager.update(:user_name=>@user_name)
      flash[:notice]="Examination Controller updated successfully."
    else
      flash[:error]="Error occured,Please try later."
    end
     if params[:change_username_by_admins]=="change_username_by_admins"
     redirect_to :action=> "controller_examiner_show"
     elsif params[:change_financial_username]=="change_username_by_manager"
       redirect_to :action=> "change_credential"
     end
     
	 end

   def select_employee_for_specialization
employee_data=MgEmployee.find_by(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:is_hod=>1,:hod_specialization_id=>params[:id])
str='<option value="">Select</option>'
       
          str +="<option value='#{employee_data.try(:id)}'  >#{employee_data.try(:first_name)} </option>"
       
        @object=str
    respond_to do |format|
          format.json  { render :json => {main: @object} }
        end

   end
def show_hod_login_credentials
    @financial_obj=MgUser.find_by(:id=>params[:id])
    render :layout=>false
  
   end
	 def employee_question_paper


	end

  	def index
  		@exam_types=MgExamType.where(:is_deleted => 0, :mg_school_id=>session[:current_user_school_id]).paginate(page: params[:page], per_page: 10)
  	end
  	def new 
		@exam_types=MgExamType.new
		render :layout => false
	end
	

	def create
		@exam_types=MgExamType.new(exam_types_params)
	  	if @exam_types.save
	  		flash[:notice]="Exam Type created successfully"
	  	else
	  		flash[:error]="Exam Type not created successfully. Error occured, please contact administrator "
	  	end
	    redirect_to :back
	end

	def show
		@exam_types = MgExamType.find(params[:id])
		render :layout => false
	end

	def edit
	 	@exam_types = MgExamType.find(params[:id])
	 	render :layout => false
	end

	def update
		@exam_types = MgExamType.find(params[:id])
	  if @exam_types.update(exam_types_params)
	  	flash[:notice]="Exam Type updated successfully"
	  else
		flash[:error]="Exam Type not updated successfully. Error occured, please contact administrator "
	  end
	  redirect_to :back
	end
	def delete
		@exam_types=MgExamType.find_by_id(params[:id])
		@exam_types.is_deleted =1
		@exam_types.save
	  	redirect_to :back
	end

	def examination_category
		@examination_category=MgExaminationCategory.where(:is_deleted => 0, :mg_school_id=>session[:current_user_school_id]).paginate(page: params[:page], per_page: 10)
	end


  	def examination_category_new 
		@examination_category=MgExaminationCategory.new
		render :layout => false
	end
	

	def examination_category_create
		@examination_category=MgExaminationCategory.new(examination_category_params)
	  	if @examination_category.save
	  		flash[:notice]="Examination Category created successfully"
	  	else
	  		flash[:error]="Examination Category not created successfully. Error occured, please contact administrator "
	  	end
	    redirect_to :back
	end

	def examination_category_show
		@examination_category = MgExaminationCategory.find(params[:id])
		render :layout => false
	end

	def examination_category_edit
	 	@examination_category = MgExaminationCategory.find(params[:id])
	 	render :layout => false
	end

	def examination_category_update
		@examination_category = MgExaminationCategory.find(params[:id])
		 
	  if @examination_category.update(examination_category_params)
	  	flash[:notice]="Examination Category updated successfully"
	  else
		flash[:error]="Examination Category not updated successfully. Error occured, please contact administrator "
	  end
	  redirect_to :back
	end

	def examination_category_delete
		@examination_category=MgExaminationCategory.find_by_id(params[:id])
		@examination_category.is_deleted =1
		@examination_category.save
	  	redirect_to :back
	end


	def examination
		@examination=MgExaminationDetail.where(:is_deleted => 0, :mg_school_id=>session[:current_user_school_id]).paginate(page: params[:page], per_page: 10)
		
	end

	def new_examination
		@examination=MgExaminationDetail.new
		
	end
	def edit_examination
		mg_school_id=session[:current_user_school_id]
		@school=MgSchool.find(mg_school_id)
		@examination = MgExaminationDetail.find(params[:id])
		@course=MgCourse.where(:mg_wing_id=>@examination.try(:mg_wing_id), :is_deleted=>0, :mg_school_id=>mg_school_id)
		@batch=MgBatch.where(:mg_course_id=>@examination.try(:mg_course_id), :is_deleted=>0, :mg_school_id=>mg_school_id)
	 	
	 	# render :layout => false
		
	end
	def show_examination
		@examination = MgExaminationDetail.find(params[:id])
		render :layout => false
	end
	def create_examination
		school=MgSchool.find(session[:current_user_school_id])
		@examination=MgExaminationDetail.new(examination_params)
		@examination.start_date=Date.strptime(params[:examination][:start_date],school.date_format)
		@examination.end_date=Date.strptime(params[:examination][:end_date],school.date_format)
	  	if @examination.save
	  		flash[:notice]="Examination Schedule created successfully"
	  	else
	  		flash[:error]="Examination Schedule not created successfully. Error occured, please contact administrator "
	  	end
	    redirect_to :action=>'examination'
	end
	def update_examination
		@examination = MgExaminationDetail.find(params[:id])
		school=MgSchool.find(session[:current_user_school_id])
		@examination.start_date=Date.strptime(params[:examination][:start_date],school.date_format)
		@examination.end_date=Date.strptime(params[:examination][:end_date],school.date_format)
	  if @examination.update(examination_params)
	  	flash[:notice]="Examination Schedule updated successfully"
	  else
		flash[:error]="Examination Schedule not updated successfully. Error occured, please contact administrator "
	  end
	  redirect_to :action=>'examination'
	end
	def delete_examination
		@examination=MgExaminationDetail.find_by_id(params[:id])
		@examination.is_deleted =1
		@examination.save
	  	redirect_to :back
	end

	def multi_skilled_worker
		mg_school_id=session[:current_user_school_id]
		user_id=session[:user_id]
		@school=MgSchool.find(mg_school_id)
		puts "-------------------------------------------------------"
		puts params.inspect
		puts "-------------------------------------------------------"
		if params[:selecter]=='mg_wing_id'
			object=MgCourse.where(:is_deleted=>0,:mg_school_id=>mg_school_id, :mg_wing_id=>params[:id])
			str='<option value="">Select</option>'
			object.each do |s|
				str +="<option value='#{s.try(:id)}'>#{s.try(:course_name)}</option>"
			end
			@object=str
		elsif params[:selecter]=='mg_course_id'
			object=MgBatch.where(:is_deleted=>0,:mg_school_id=>mg_school_id, :mg_course_id=>params[:id])
			str='<option value="">Select</option>'
			object.each do |s|
				str +="<option value='#{s.try(:id)}'>#{s.try(:name)}</option>"
			end
			@object=str
		elsif params[:selecter]=='department'
			user=MgUser.where(:is_deleted=>0, :mg_school_id=>mg_school_id,:user_type=>['principal','superprincipal'])
			employee_ids=MgEmployee.where(:is_deleted=>0, :mg_school_id=>mg_school_id, :mg_user_id=>user.pluck(:id))#.where("id not in (?)", )
			@invigilators=MgInvigilator.where(:is_deleted=>0, :mg_school_id=>mg_school_id, :date=>Date.strptime(params[:invigilators_date],@school.date_format))
			emp_ids=[]
			@invigilators.each do |e|
				emp_ids +=e.try(:mg_invigilator_details).present? ? e.try(:mg_invigilator_details).where(:is_deleted=>0, :mg_school_id=>mg_school_id).pluck(:mg_employee_id) : []
			end
			employee=MgEmployee.where(:is_deleted=>0, :mg_school_id=>mg_school_id, :mg_employee_department_id=>params[:id], :mg_employee_category_id=>1).where("id not in ( ? )", (employee_ids.pluck(:id)+emp_ids)).order(:first_name, :last_name)
			str=''
			employee.order(:first_name, :last_name).each do |s|
				str +="<option value='#{s.try(:id)}'>#{s.try(:first_name)}(#{s.try(:employee_number)}) </option>"
			end
			employee_selected=MgEmployee.where(:is_deleted=>0, :mg_school_id=>mg_school_id, :mg_employee_department_id=>params[:id], :mg_employee_category_id=>1).where("id in ( ? )", emp_ids).order(:first_name, :last_name)
			dept_count=true
			employee_selected.order(:first_name, :last_name).each do |s|
				if dept_count
					str +="<option value='' disabled='disabled' >-- Selected employees --  </option>"
					dept_count=false
				end
				str +="<option value='#{s.try(:id)}' disabled='disabled'>#{s.try(:first_name)}(#{s.try(:employee_number)}) </option>"
			end
			@object=str
		elsif params[:selecter]=='mg_examination_detail_id'
		 	@object=MgExaminationDetail.where(:is_deleted=>0, :mg_school_id=>session[:current_user_school_id], :id=>params[:id])
		 	# subjct=MgSubject.where(:is_deleted=>0, :mg_school_id=>mg_school_id, :mg_course_id=>object[0].mg_course_id)
		 	
      # @object={object_list: object, subjct: subjct}
		
    elsif params[:selecter]=='mg_examination_detail_id_subject_specialization'
      examination_hod_logins=MgExaminationHodLogin.find_by(:mg_user_id=>session[:user_id])
      employee=MgEmployee.find_by(:id=>examination_hod_logins.mg_employee_id)
      @object_a=MgExaminationDetail.where(:is_deleted=>0, :mg_school_id=>session[:current_user_school_id], :id=>params[:id])
      object_selecter=MgExaminationTimeTable.where(:is_deleted=>0, :mg_school_id=>session[:current_user_school_id], :mg_examination_detail_id=>params[:id]).order(:date)
      subject=MgSubject.where(:is_deleted=>0, :mg_school_id=>mg_school_id, :id=>object_selecter.pluck(:mg_subject_id), :mg_employee_specialization_id=>employee.hod_specialization_id)

      object=MgWing.where(:is_deleted=>0,:mg_school_id=>mg_school_id, :id=>object_selecter.pluck(:mg_wing_id))
      str='<option value="">Select</option>'
      subject.each do |s|
        str +="<option value='#{s.try(:id)}'>#{s.try(:subject_name)}</option>"
      end



      @object={ :exam=>@object_a, :wings=>str}
    elsif params[:selecter]=='mg_wing_id_for_subject_specialization'
      object_selecter=MgExaminationTimeTable.where(:is_deleted=>0, :mg_school_id=>session[:current_user_school_id], :mg_examination_detail_id=>params[:id], :mg_wing_id=>params[:mg_wing_id]).pluck(:mg_batch_id)
      puts ""
      exam=MgExaminationDetail.find_by(:id=>params[:id])
      puts object_selecter.inspect
      puts ""
      # object=MgCourse.where(:is_deleted=>0,:mg_school_id=>mg_school_id, :id=>object_selecter)
      object=MgBatch.where(:is_deleted=>0,:mg_school_id=>mg_school_id, :id=>object_selecter)

      str='<option value="">Select</option>'
      object.each do |s|
        str +="<option value='#{s.try(:id)}'>#{s.try(:course_batch_name)}</option>"
      end
      @object=str
    elsif params[:selecter]=='examination_detail_for_seating_plan'
			object_selecter=MgExaminationTimeTable.where(:is_deleted=>0, :mg_school_id=>session[:current_user_school_id], :mg_examination_detail_id=>params[:id]).order(:date)
			object=MgWing.where(:is_deleted=>0,:mg_school_id=>mg_school_id, :id=>object_selecter.pluck(:mg_wing_id))
			str='<option value="">Select</option>'
			object.each do |s|
				str +="<option value='#{s.try(:id)}'>#{s.try(:wing_name)}</option>"
			end
			object_selecter.inspect
			str1='<option value="">Select</option>'
			# object_selecter.order(:date, :start_time).each do |s|
			#str1 +="<option value='#{s.try(:id)}'>#{s.try(:date).strftime(@school.date_format)} (#{s.try(:start_time).strftime('%I:%M%p')} to #{s.try(:end_time).strftime('%I:%M%p')})</option>"
			# end
      
object_selecter.pluck(:date).uniq.each do |s|
          
           str1 +="<option value='#{s}'>#{s.strftime(@school.date_format)}</option>"

  
      end

			@object={wing_list: str, date_list: str1}
          elsif params[:selecter]=='examination_detail_for_seating_plan_time_data'
      object_selecter=MgExaminationTimeTable.where(:is_deleted=>0, :mg_school_id=>session[:current_user_school_id], :date=>params[:id])
     str1='<option value="">Select</option>'
      object_selecter.order(:start_time).each do |s|
        str1 +="<option value='#{s.try(:id)}'>#{s.try(:start_time).strftime('%I:%M%p')} to #{s.try(:end_time).strftime('%I:%M%p')}</option>"
      end
      @object={date_list: str1}
		elsif params[:selecter]=='mg_wing_id_for_seating_plan'
			object_selecter=MgExaminationTimeTable.where(:is_deleted=>0, :mg_school_id=>session[:current_user_school_id], :mg_examination_detail_id=>params[:id], :mg_wing_id=>params[:mg_wing_id]).pluck(:mg_batch_id)
			puts ""
			exam=MgExaminationDetail.find_by(:id=>params[:id])
			puts object_selecter.inspect
			puts ""
			# object=MgCourse.where(:is_deleted=>0,:mg_school_id=>mg_school_id, :id=>object_selecter)
			object=MgBatch.where(:is_deleted=>0,:mg_school_id=>mg_school_id, :id=>object_selecter)

			str=''
			object.each do |s|
				str +="<option value='#{s.try(:id)}'>#{s.try(:course_batch_name)}</option>"
			end
			@object=str
		elsif params[:selecter]=='mg_course_id_for_seating_plan'
			# course=MgCourse.find_by(:id=>params[:id])
			

			batch=MgBatch.find_by(:is_deleted=>0,:mg_school_id=>mg_school_id, :id=>params[:id])
			course=MgCourse.find_by(:id=>batch.try(:mg_course_id))
			object=MgStudent.where(:is_deleted=>0,:mg_school_id=>mg_school_id, :mg_batch_id=>params[:id])
			str=''
			selected_obj=[]
      puts "step ~ 1"
			object.order(:first_name, :last_name).each do |s|
        puts "step ~ 2"
				test=nil
        obj=MgExamSeatingPlan.where(:mg_examination_detail_id=>params[:mg_examination_detail_id],:is_deleted=>0, :mg_school_id=>mg_school_id, :mg_examination_time_table_id=>params[:mg_examination_time_table_id])#.try(:id)
				# :mg_institute_room_id=>params[:mg_institute_room_id]
        puts "------- t-1 -------"
        puts obj.inspect
        puts "------- t-2 -------"
        if obj.present?
          # selected_obj.push(s)
      #     puts "step ~ 2-1"
         
  				# puts "------"
      #     puts test1.inspect
      #     puts "step ~ 3"
      #     if test1.present?
      #       puts "step ~ 4"
  				# 	test=MgExamSeatingPlanDetail.where(:mg_exam_seating_plan=>obj.id, :is_deleted=>0, :mg_school_id=>mg_school_id, :mg_student_id=>s.id)
  				# else
      #       puts "step ~ 5"
  				# 	test=MgExamSeatingPlanDetail.find_by(:is_deleted=>0, :mg_school_id=>mg_school_id, :mg_student_id=>s.id)
  				# end
      #     puts "step ~ 3-1"
  				# if(test.present?)
      #       puts "step ~ 6"
  				# 	selected_obj.push(s)
  				# else
      #       puts "step ~ 7"
  				# 	str +="<option value='#{s.try(:id)}'>#{s.try(:first_name)}(#{course.try(:code)}-#{batch.try(:name)}) </option>"
  				# end
          test1=MgExamSeatingPlanDetail.where(:mg_exam_seating_plan=>obj.pluck(:id), :is_deleted=>0, :mg_school_id=>mg_school_id, :mg_student_id=>s.id)
          if test1.present?
            selected_obj.push(s)
          else
            str +="<option value='#{s.try(:id)}'>#{s.try(:first_name)}(#{course.try(:code)}-#{batch.try(:name)}) </option>"
          end
        else
          str +="<option value='#{s.try(:id)}'>#{s.try(:first_name)}(#{course.try(:code)}-#{batch.try(:name)}) </option>"
          puts "step ~ 12"
        end

			end


			count=0
      puts "step ~ 8"
			selected_obj.each do |s|
        puts "step ~ 9"
				if count==0
          puts "step ~ 10"
					str +="<option value='' disabled='disabled' >-- Selected students --  </option>"
					count=1
				end
				str +="<option value='#{s.try(:id)}' disabled='disabled' >#{s.try(:first_name)}(#{course.try(:code)}-#{batch.try(:name)}) </option>"
			end
      puts "step ~ 20"
			@object=str
		elsif params[:selecter]=='mg_employee_specialization_id_for_seating_plan'
		date_obj=MgExaminationTimeTable.find_by(:id=>params[:date_time],:is_deleted=>0, :mg_school_id=>mg_school_id, :mg_examination_detail_id=>params[:mg_examination_detail_id])
			
			object=MgInstituteRoom.where(:is_deleted=>0, :mg_school_id=>session[:current_user_school_id], :mg_employee_specialization_id=>params[:id])
			selected_obj=[]
			str='<option value="">Select</option>'
			object.each do |s|
				test=MgExamSeatingPlan.find_by(:is_deleted=>0, :mg_school_id=>mg_school_id, :mg_institute_room_id=>s.id, :date=>date_obj.try(:date), :start_time=>date_obj.try(:start_time),:end_time=>date_obj.try(:end_time))
				if(test.present?)
					selected_obj.push(s)
				else
					str +="<option value='#{s.try(:id)}'  >#{s.try(:room_no)} </option>"
				end
			end
			count=0
			selected_obj.each do |s|
				if count==0
					str +="<option value='' disabled='disabled' >--- Selected rooms ---  </option>"
					count=1
				end
				str +="<option value='#{s.try(:id)}' disabled='disabled' >#{s.try(:room_no)} </option>"
			end
			@object=str
		elsif params[:selecter]=='select_examination_detail_hall_tiket'
			object_selecter=MgExaminationTimeTable.where(:is_deleted=>0, :mg_school_id=>session[:current_user_school_id], :mg_examination_detail_id=>params[:id])
			object=MgWing.where(:is_deleted=>0,:mg_school_id=>mg_school_id, :id=>object_selecter.pluck(:mg_wing_id))
			exam=MgExaminationDetail.find_by(:id=>params[:id])
			str='<option value="">Select</option>'
			object.each do |s|
				str +="<option value='#{s.try(:id)}'>#{s.try(:wing_name)}</option>"
			end
			@object={str: str, acadimic_year: exam.try(:mg_time_table_id) }
		elsif params[:selecter]=='mg_wing_id_mg_batch_id'
			exam=MgExaminationDetail.find_by(:id=>params[:mg_examination_detail_id])
			@acadimic_year=MgTimeTable.find_by(:id=>exam.mg_time_table_id)
			@course_id=MgCourse.where(:is_deleted=>0, :mg_school_id=>mg_school_id, :mg_wing_id=>params[:mg_wing_id])
			# @academic_years  =   MgTimeTable.where("start_date < \"#{Date.today}\" && \"#{Date.today}\" < end_date").where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id])
			@batch_list =MgBatch.where("start_date >=? and end_date <=? and is_deleted=? and mg_school_id=?",@acadimic_year.try(:start_date),@acadimic_year.try(:end_date),0,session[:current_user_school_id])
	  		@batch_id = @batch_list.where("mg_course_id IN (?)",@course_id.pluck(:id))

	  		
	  		str='<option value="">Select</option>'
	  		@batch_id.each do |i|
	  			str +="<option value='#{i.try(:id)}'  >#{i.try(:course_batch_name)} </option>"
	  		end
	  		@object=str
    elsif params[:selecter]=='mg_batch_id_for_subject_specialization'
      # :mg_employee_specialization_id=>3, 
      specialization=MgSubject.where(:is_deleted=>0, :mg_school_id=>session[:current_user_school_id]).pluck(:id)
      @object_b=MgExaminationTimeTable.where(:is_deleted=>0, :mg_school_id=>session[:current_user_school_id], :mg_examination_detail_id=>params[:mg_examination_detail_id], :mg_batch_id=>params[:mg_batch_id], :mg_subject_id=>specialization)
      str='<option value="">Select</option>'
      @object_b.each do |a|
         str +="<option value='#{a.id}'>#{a.date.strftime(@school.date_format)}</option>"
      end
      @object=str
    elsif params[:selecter]=='mg_examination_time_table_id_for_subject_specialization'
      specialization=MgSubject.where(:is_deleted=>0, :mg_school_id=>session[:current_user_school_id]).pluck(:id)

      examination_time_table=MgExaminationTimeTable.find_by(:id=>params[:mg_examination_time_table_id])
      @object_b=MgExaminationTimeTable.where(:is_deleted=>0, :mg_school_id=>session[:current_user_school_id], :mg_examination_detail_id=>params[:mg_examination_detail_id], :mg_batch_id=>params[:mg_batch_id], :mg_subject_id=>specialization)
    
    elsif params[:selecter]=='mg_employee_id_for_subject_specialization'
      subject=MgSubject.where(:is_deleted=>0, :mg_school_id=>mg_school_id, :id=>params[:mg_subject_id])
      # mg_employee_specialization_id
      particular_specialization=MgParticularSpecialization.where(:is_deleted=>0, :mg_school_id=>mg_school_id,:mg_employee_specialization_id=>subject.pluck(:mg_employee_specialization_id)).pluck(:mg_employee_id)
      employee=MgEmployee.where(:is_deleted=>0, :mg_school_id=>mg_school_id, :id=>particular_specialization)
      str='<option value="">Select</option>'
      employee.each do |a|
         str +="<option value='#{a.id}'>#{a.first_name.try(:titleize)} #{a.last_name.try(:titleize)} (#{a.employee_number})</option>"
      end
      @object=str
		end
		# date_obj=MgExaminationTimeTable.find_by(:id=>params[:date_time],:is_deleted=>0, :mg_school_id=>mg_school_id, :mg_examination_detail_id=>params[:seating_plan][:mg_examination_detail_id])

		

		respond_to do |format|
        	format.json  { render :json => {main: @object, sub: ""} }
      	end
	end

	def invigilators
		@school=MgSchool.find(session[:current_user_school_id])
  		@invigilators=MgInvigilator.where(:is_deleted => 0, :mg_school_id=>session[:current_user_school_id]).paginate(page: params[:page], per_page: 10)
	end

  	def new_invigilators 
		@invigilators=MgInvigilator.new
		# render :layout => false
	end
	

	def create_invigilators
		# puts kgfjjdhjhfghdfhgk
		mg_school_id=session[:current_user_school_id]
		user_id=session[:user_id]
		@timeformat=MgSchool.find(mg_school_id)
		@invigilators=MgInvigilator.new(invigilators_params)
		if params[:selected_employees].present?
		   for i in 0...params[:selected_employees].size
				@invigilators.mg_invigilator_details.build(:mg_employee_id=>params[:selected_employees][i],:is_deleted=>0, :mg_school_id=>mg_school_id,:created_by=>user_id, :updated_by=>user_id)
		   end
		end
		@invigilators.date=Date.strptime(params[:invigilators][:date],@timeformat.date_format)
	  	if @invigilators.save
	  		flash[:notice]="Invigilators Details saved successfully"
	    	redirect_to :action=>'invigilators'
	  	else
	  		flash[:error]="Invigilators Details not saved successfully. Error occured, please contact administrator "
	  		render 'new_invigilators'
	  	end
	    
	end

	def show_invigilators
		mg_school_id=session[:current_user_school_id]
		@school=MgSchool.find(mg_school_id)
		@invigilators = MgInvigilator.find(params[:id])
		employee=MgEmployee.where(:id=>@invigilators.mg_invigilator_details.where(:is_deleted=>0).pluck(:mg_employee_id), :is_deleted=>0, :mg_school_id=>mg_school_id)
		@employee=[]
		employee.order(:first_name, :last_name).each do |s|
			@employee.push("#{s.try(:first_name)} #{s.try(:last_name)} (#{s.try(:employee_number)})" )
		end
		render :layout => false
	end

	def edit_invigilators
		mg_school_id=session[:current_user_school_id]
		@school=MgSchool.find(mg_school_id)
	 	@invigilators = MgInvigilator.find(params[:id])
	 	employee=MgEmployee.where(:is_deleted=>0, :mg_school_id=>mg_school_id, :id=>@invigilators.mg_invigilator_details.where(:is_deleted=>0).pluck(:mg_employee_id))
	 	@employee=[]
	 	@seleted=employee.pluck(:id)
	 	# @employee=employee.pluck(:first_name,:id)
	 	employee.order(:first_name, :last_name).each do |e|
	 		@employee.push([ "#{e.try(:first_name)}(#{e.try(:employee_number)}) ",e.try(:id)])
	 	end
	 	
	 	# render :layout => false
	end

	def update_invigilators
		mg_school_id=session[:current_user_school_id]
		user_id=session[:user_id]
		
		@timeformat=MgSchool.find(mg_school_id)
		@invigilators=MgInvigilator.find(params[:id])
		@invigilators.mg_invigilator_details.update_all(:is_deleted=>1)
		if params[:selected_employees].present?
		   for i in 0...params[:selected_employees].size
				@invigilators.mg_invigilator_details.build(:mg_employee_id=>params[:selected_employees][i],:is_deleted=>0, :mg_school_id=>mg_school_id,:created_by=>user_id, :updated_by=>user_id)
		   end
		end
		
	  if @invigilators.update(invigilators_params)
	  		@invigilators.date=Date.strptime(params[:invigilators][:date],@timeformat.date_format)
	  		@invigilators.save
	  		flash[:notice]="Invigilator Details updated successfully"
	    	redirect_to :action=>'invigilators'
	  else
			flash[:error]="Invigilator Details not updated successfully. Error occured, please contact administrator "
	  		render 'edit_invigilators'
	  end
	end
	def delete_invigilators
		@invigilators=MgInvigilator.find_by_id(params[:id])
		@invigilators.is_deleted =1
		@invigilators.save
	  	redirect_to :back
	end

	def invigilators_details
		mg_school_id=session[:current_user_school_id]
		@school=MgSchool.find(mg_school_id)
		@date=Date.today
		if params[:date].present?
			@date=Date.strptime(params[:date],@school.date_format)
		end
		employee=MgEmployee.find_by(:mg_user_id=>session[:user_id])
		@invigilator_details=MgInvigilatorDetail.where(:is_deleted=>0, :mg_school_id=>mg_school_id, :mg_employee_id=>employee.id).includes(:mg_invigilator).where("date= ? ", @date).order("mg_invigilators.date")#.paginate(page: params[:page], per_page: 10)#employee.id)
	    puts @invigilator_details.inspect
	end

	def invigilation_details
		# @invigilation_details
		@school=MgSchool.find(session[:current_user_school_id])
  		@invigilators=MgInvigilator.where(:is_deleted => 0, :mg_school_id=>session[:current_user_school_id]).paginate(page: params[:page], per_page: 10)
	end

	
	def time_table
  		@time_table=MgExaminationDetail.where(:id=>MgExaminationTimeTable.where(:is_deleted => 0, :mg_school_id=>session[:current_user_school_id]).pluck(:mg_examination_detail_id)).paginate(page: params[:page], per_page: 10)
  		
  	end
  	def new_time_table 
		@time_table=MgExaminationTimeTable.new
  		@exam_types=MgExamType.where(:is_deleted=>0, :mg_school_id=>session[:current_user_school_id]).pluck(:name, :id)
  		@examination_category=MgExaminationCategory.where(:is_deleted=>0, :mg_school_id=>session[:current_user_school_id]).pluck(:name, :id)
  		@acadimic_year=MgTimeTable.where(:is_deleted=>0, :mg_school_id=>session[:current_user_school_id]).pluck(:name, :id)
  		@wing=MgWing.where(:is_deleted=>0, :mg_school_id=>session[:current_user_school_id]).pluck(:wing_name, :id)
  		@examination_program_category=MgExaminationProgramCategory.where(:is_deleted=>0, :mg_school_id=>session[:current_user_school_id]).pluck(:name, :id)
  		@course=MgCourse.where(:is_deleted=>0, :mg_school_id=>session[:current_user_school_id]).pluck(:course_name, :id)
  		
		# render :layout => false
	end
	

	def create_time_table
		mg_school_id=session[:current_user_school_id]
		time_table_arr=[]
		school=MgSchool.find(mg_school_id)
		begin
			obj=MgExaminationTimeTable.where(:mg_examination_detail_id=>params[:time_table][:mg_examination_detail_id], :mg_batch_id=>params[:time_table][:mg_batch_id], :is_deleted=>0, :mg_school_id=>mg_school_id)
			if obj.present?
				obj.update_all(:is_deleted=>1)
			end
			MgExaminationTimeTable.transaction do
				if params[:mg_subject_id].present?
					for i in  0..params[:mg_subject_id].size
						if(params[:max_marks][params[:mg_subject_id][i]].present? && params[:date][params[:mg_subject_id][i]].present? && params[:pass_marks][params[:mg_subject_id][i]].present? && params[:start_time][params[:mg_subject_id][i]].present? && params[:end_time][params[:mg_subject_id][i]].present?)
							time_table =MgExaminationTimeTable.new(time_table_params)
							batch=MgBatch.find_by(:id=>params[:time_table][:mg_batch_id])
							time_table.mg_course_id=batch.try(:mg_course_id)
							time_table.max_marks = params[:max_marks][params[:mg_subject_id][i]]
							time_table.date = Date.strptime(params[:date][params[:mg_subject_id][i]],school.date_format)
							time_table.pass_marks = params[:pass_marks][params[:mg_subject_id][i]]
							time_table.start_time = params[:start_time][params[:mg_subject_id][i]]
							time_table.end_time = params[:end_time][params[:mg_subject_id][i]]
							time_table.mg_subject_id = params[:mg_subject_id][i]
							time_table_arr.push(time_table.save)
						end
					end
				end
			end
		  	if !time_table_arr.include?(false)
		  		flash[:notice]="Time table created successfully"
		  	else
		  		flash[:error]="Time table not created successfully. Error occured, please contact administrator "
		  	end
	  	rescue Exception => e
			puts e
			flash[:error]="Error occured, please contact administrator "
		end
	    redirect_to :action=>'time_table'
	end

	def show_time_table
		mg_school_id=session[:current_user_school_id]
		@school=MgSchool.find(mg_school_id)
		@examination_detail = MgExaminationDetail.find(params[:id])
		@time_table=MgExaminationTimeTable.where(:mg_examination_detail_id=>params[:id], :is_deleted=>0, :mg_school_id=>mg_school_id)
		# render :layout => false
	end



	def edit_time_table
		mg_school_id=session[:current_user_school_id]
	 	@examination_detail = MgExaminationDetail.find(params[:id])
	 	@time_table=MgExaminationTimeTable.find_by(:is_deleted=>0, :mg_school_id=>mg_school_id, :mg_examination_detail_id=>@examination_detail.id)
	 	# @time_table_obj=MgExaminationTimeTable.where(:is_deleted=>0, :mg_school_id=>mg_school_id, :mg_examination_detail_id=>@examination_detail.id)

	 	@exam_types=MgExamType.where(:is_deleted=>0, :mg_school_id=>session[:current_user_school_id]).pluck(:name, :id)
  		@examination_category=MgExaminationCategory.where(:is_deleted=>0, :mg_school_id=>session[:current_user_school_id]).pluck(:name, :id)
  		@acadimic_year=MgTimeTable.where(:is_deleted=>0, :mg_school_id=>session[:current_user_school_id]).pluck(:name, :id)
  		@wing=MgWing.where(:is_deleted=>0, :mg_school_id=>session[:current_user_school_id]).pluck(:wing_name, :id)
  		@examination_program_category=MgExaminationProgramCategory.where(:is_deleted=>0, :mg_school_id=>session[:current_user_school_id]).pluck(:name, :id)
  		@course=MgCourse.where(:is_deleted=>0, :mg_school_id=>session[:current_user_school_id]).pluck(:course_name, :id)
  		@subject=MgSubject.where(:is_deleted=>0, :mg_school_id=>session[:current_user_school_id], :mg_course_id=>@examination_detail.mg_course_id)
	 	# render :layout => false
	end

	def update_time_table
		@time_table = MgExaminationTimeTable.find(params[:id])
	  if @time_table.update(exam_types_params)
	  	flash[:notice]="Time table updated successfully"
	  else
		flash[:error]="Time table not updated successfully. Error occured, please contact administrator "
	  end
	  redirect_to :back
	end
	def delete_time_table
		@time_table=MgExaminationTimeTable.where(:mg_examination_detail=>params[:id], :is_deleted=>0, :mg_school_id=>session[:current_user_school_id])
		# @time_table.is_deleted =1
		@time_table.update_all(:is_deleted=>1)
	  	redirect_to :back
	end
	def subject_list
		mg_school_id=session[:current_user_school_id]
		@school=MgSchool.find(mg_school_id)
		course_id=MgBatch.find_by(:is_deleted=>0, :mg_school_id=>mg_school_id, :id=>params[:id])
		@subject=MgSubject.where(:is_deleted=>0, :mg_school_id=>mg_school_id, :mg_course_id=>course_id.try(:mg_course_id))
		@time_table=MgExaminationTimeTable.where(:is_deleted=>0, :mg_school_id=>mg_school_id, :mg_examination_detail_id=>params[:mg_examination_detail_id])
		render :layout => false
		
	end

	def exam_time_table_show
		mg_school_id=session[:current_user_school_id]
		@school=MgSchool.find(mg_school_id)
		@examination_detail = MgExaminationDetail.find(params[:id])
		@time_table=MgExaminationTimeTable.where(:mg_examination_detail_id=>params[:id], :is_deleted=>0, :mg_school_id=>mg_school_id, :mg_course_id=>params[:mg_course_id])
		render :layout => false
	end

	def seating_plan
		@school=MgSchool.find(session[:current_user_school_id])
  		@seating_plan=MgExamSeatingPlan.where(:is_deleted => 0, :mg_school_id=>session[:current_user_school_id]).paginate(page: params[:page], per_page: 10)
  	
  	end
  	def new_seating_plan
		@seating_plan=MgExamSeatingPlan.new
		# before=MgExamSeatingPlan.where(:is_deleted=>0, :mg_school_id=>session[:current_user_school_id]).pluck(:mg_examination_detail_id)
		# if before.present?
		# 	@examination=MgExaminationDetail.where(:is_deleted=>0, :mg_school_id=>session[:current_user_school_id]).where("id not in (?)", before)
		# else
			@examination=MgExaminationDetail.where(:is_deleted=>0, :mg_school_id=>session[:current_user_school_id])
		# end
	end

	def create_seating_plan
		mg_school_id=session[:current_user_school_id]
		user_id=session[:user_id]
		begin
			MgExamSeatingPlan.transaction do
				if params[:mg_student_id].present?
					date_obj=MgExaminationTimeTable.find_by(:id=>params[:date_time],:is_deleted=>0, :mg_school_id=>mg_school_id, :mg_examination_detail_id=>params[:seating_plan][:mg_examination_detail_id])
					@seating_plan=MgExamSeatingPlan.new(seating_plan_params)
					@seating_plan.start_time=date_obj.start_time
					@seating_plan.end_time=date_obj.end_time
					@seating_plan.date=date_obj.date
					@seating_plan.mg_examination_time_table_id=params[:date_time]
					for i in 0...params[:mg_student_id].size
						puts params[:mg_student_id][i]
						student=MgStudent.find_by(:id=>params[:mg_student_id][i])
						batch=MgBatch.find_by(:id=>student.try(:mg_batch_id))
						course=MgCourse.find_by(:id=>batch.try(:mg_course_id))
						seating_plan_details=@seating_plan.mg_exam_seating_plan_details.build(:is_deleted=>0, :mg_school_id=>mg_school_id, :created_by=>user_id, :updated_by=>user_id)
						seating_plan_details.mg_course_id=batch.try(:mg_course_id)
						seating_plan_details.mg_wing_id=course.try(:mg_wing_id)
						seating_plan_details.mg_student_id=params[:mg_student_id][i]
						seating_plan_details.save
					end
				end
			end
		  	if @seating_plan.save
		  		flash[:notice]="Created successfully"
		  	else
		  		flash[:error]="Not created successfully. Error occured, please contact administrator "
		  	end
		rescue Exception => e
			puts e
		  	flash[:error]="Error occured, please contact administrator "
		end
	    redirect_to :action=>'seating_plan'
	end

	def show_seating_plan
		@school=MgSchool.find(session[:current_user_school_id])
		@seating_plan = MgExamSeatingPlan.find(params[:id])
		render :layout => false
	end

	def edit_seating_plan
		mg_school_id=session[:current_user_school_id]
	 	@seating_plan = MgExamSeatingPlan.find(params[:id])
	 	@school=MgSchool.find(session[:current_user_school_id])
	 	before=MgExamSeatingPlan.where(:is_deleted=>0, :mg_school_id=>mg_school_id).pluck(:mg_examination_detail_id)
		@examination=MgExaminationDetail.where(:is_deleted=>0, :mg_school_id=>mg_school_id)
		object_selecter=MgExaminationTimeTable.where(:is_deleted=>0, :mg_school_id=>mg_school_id, :mg_examination_detail_id=>@seating_plan.try(:mg_examination_detail_id)).pluck(:mg_wing_id)
		@wing=MgWing.where(:is_deleted=>0,  :mg_school_id=>mg_school_id, :id=>object_selecter).pluck(:wing_name, :id)
		@student_list=[]
		@student_list_id=[]

		@seating_plan.mg_exam_seating_plan_details.where(:is_deleted=>0,:mg_school_id=>mg_school_id).order(:mg_course_id).each do |e|
			student=MgStudent.find_by(:id=>e.try(:mg_student_id))
			course=MgCourse.find_by(:id=>e.try(:mg_course_id))
			batch=MgBatch.find_by(:id=>student.try(:mg_batch_id))
			@student_list.push(["#{student.try(:first_name)}(#{course.try(:code)}-#{batch.try(:name)})", student.try(:id)])
			@student_list_id.push(student.try(:id))
		end

		object_selecter=MgExaminationTimeTable.where(:is_deleted=>0, :mg_school_id=>session[:current_user_school_id], :mg_examination_detail_id=>before)
			
			@time_table=[]
			object_selecter.order(:date, :start_time).each do |s|
				@time_table.push([ "#{s.try(:date).strftime(@school.date_format)} (#{s.try(:start_time).strftime('%I:%M%p')} to #{s.try(:end_time).strftime('%I:%M%p')})",s.try(:id)])
			end

	end

	def update_seating_plan
		mg_school_id=session[:current_user_school_id]
		user_id=session[:user_id]
		begin
			MgExamSeatingPlan.transaction do
				if params[:mg_student_id].present?
					@seating_plan=MgExamSeatingPlan.find(params[:id])
					@seating_plan.mg_exam_seating_plan_details.update_all(:is_deleted=>1)
					# date_obj=MgExaminationTimeTable.find_by(:id=>params[:date_time],:is_deleted=>0, :mg_school_id=>mg_school_id, :mg_examination_detail_id=>params[:seating_plan][:mg_examination_detail_id])
					# @seating_plan.start_time=date_obj.start_time
					# @seating_plan.end_time=date_obj.end_time
					# @seating_plan.date=date_obj.date
					# @seating_plan.mg_examination_time_table_id=params[:date_time]	
					for i in 0...params[:mg_student_id].size
						puts params[:mg_student_id][i]
						student=MgStudent.find_by(:id=>params[:mg_student_id][i])
						batch=MgBatch.find_by(:id=>student.try(:mg_batch_id))
						course=MgCourse.find_by(:id=>batch.try(:mg_course_id))
						seating_plan_details=@seating_plan.mg_exam_seating_plan_details.build(:is_deleted=>0, :mg_school_id=>mg_school_id, :created_by=>user_id, :updated_by=>user_id)
						seating_plan_details.mg_course_id=batch.try(:mg_course_id)
						seating_plan_details.mg_wing_id=course.try(:mg_wing_id)
						seating_plan_details.mg_student_id=params[:mg_student_id][i]
						seating_plan_details.save
					end
				end
			end
		  	if @seating_plan.update(seating_plan_params)
		  		flash[:notice]="Updated successfully"
		  	else
		  		flash[:error]="not updated successfully. Error occured, please contact administrator "
		  	end
		rescue Exception => e
			puts e
		  	flash[:error]="Error occured, please contact administrator "
		end
	    redirect_to :action=>'seating_plan'
	end
	def delete_seating_plan
		@seating_plan=MgExamSeatingPlan.find_by_id(params[:id])
		@seating_plan.is_deleted =1
		@seating_plan.mg_exam_seating_plan_details.update_all(:is_deleted=>1)
	  	respond_to do |format|
        	format.json  { render :json => {main: @seating_plan.save ? true : false} }
      	end
	end
	def generate_excel
		mg_school_id=session[:current_user_school_id]
		@school=MgSchool.find(mg_school_id)
		@examination_detail = MgExaminationDetail.find(params[:id])
		@exam_plan=MgExamSeatingPlan.where(:is_deleted=>0,:mg_school_id=>mg_school_id, :mg_examination_detail_id=>params[:id])
		

		# params[:format]='xls'
		# # respond_to do |format|
	 #      # format.xls do
	 #        response.headers['Content-Disposition'] = 'attachment; filename="' + "#{ Date.today} seating plan" + '.xls"'
	 #        render "generate_excel.xls.erb"
	      # end
	    # end

	  mg_school_id=session[:current_user_school_id]
	  begin
	    if File.exists?(File.join(Rails.root, "public/xlsx_files", "exam_excel.xlsx"))
	      File.delete(File.join(Rails.root, "public/xlsx_files", "exam_excel.xlsx"))
	    end
	    # GatePass.new(mg_school_id,params[:id], 2)
		ExamDetails.new(mg_school_id, params[:id])

	    send_file File.exists?(File.join(Rails.root, "public/xlsx_files", "exam_excel.xlsx")) ? File.join(Rails.root, "public/xlsx_files", "exam_excel.xlsx") : File.join(Rails.root, "public/xlsx_files", "gate_pass_error.xlsx"), :type => "application/vnd.ms-excel", :filename => "gate_pass-(#{Date.today}).xlsx", :stream => false#, :readonly=>true
	  rescue Exception => e
	    puts e
	    if File.exists?(File.join(Rails.root, "public/xlsx_files", "gate_pass_error.xlsx"))
	      send_file File.join(Rails.root, "public/xlsx_files", "gate_pass_error.xlsx"), :type => "application/vnd.ms-excel", :filename => "gate_pass-(#{Date.today}).xlsx", :stream => false#, :readonly=>true
	    end
	  end
	end
	def exam_notification
		
	end
	def send_notification
		mg_school_id=session[:current_user_school_id]
		batch=MgBatch.where(:is_deleted=>0, :mg_school_id=>mg_school_id, :id=>params[:mg_batch_id])
		student=MgStudent.where(:is_deleted=>0, :mg_school_id=>mg_school_id, :mg_batch_id=>params[:mg_batch_id])
		user_id=session[:user_id]
		user=MgEmail.find_by(:mg_user_id=>user_id)
		# admin=MgUser.where(:is_deleted=>0, :mg_school_id=>mg_school_id)\
		object=Hash.new
				object["mg_course_id"]=batch[0].mg_course_id
				object["mg_school_id"]=mg_school_id
				object["mg_examination_detail_id"]=params[:mg_examination_detail_id]
		subject="Examination Details"
		student.each do |s|
			begin
				puts 'IN SIDE STUDENT LOOP----------------> START'
				s_user=MgEmail.find_by(:mg_user_id=>s.mg_user_id)
																	# (from_user_id,to_user_id,subject,description,school_id,is_deleted,created_by,updated_by)
				notification=MgNotification.send_notification(user_id,s.try(:mg_user_id).to_i,subject,params[:description],mg_school_id,0,user_id,user_id)
				notification.save
				puts 'IN SIDE STUDENT LOOP----------------> MIDDELE'

				# email=MgNotification.send_time_table_email(user.try(:mg_email_id),s_user.try(:mg_email_id),subject,params[:description],mg_school_id, object)
				# email.save
        result =send_mail_method(user.try(:mg_email_id),s_user.try(:mg_email_id),subject,params[:description],mg_school_id, object)
				@notice_msg="Mail send successfully"
				puts 'IN SIDE STUDENT LOOP----------------> END'

			rescue Net::SMTPFatalError => e
				puts e
		       	@notice= 'Email-Id is not valid.'
		    rescue ArgumentError=>e
		    	puts e
		      	@notice='Email to address is not present.'
		    rescue Exception=>e
		    	puts e
		      	@notice='Error while sending email, Please contact admin.'
		    end
		end
		flash[:notice]=@notice.present? ? @notice.to_s : @notice_msg.to_s
	    redirect_to :action=>'exam_notification'

	end

	def send_exam_email
		
	end

  def send_mail_method(user_mg_email_id,s_user_mg_email_id,subject,description,mg_school_id, object)
    puts "so what----- ----- ----- - ---- - --- ------- - ------- - ----> "
    user_mg_email_id='dharaniks@mindcomgroup.com'
    #s_user_mg_email_id=user_mg_email_id
    begin
      email=MgNotification.send_time_table_email(user_mg_email_id,s_user_mg_email_id,subject,description,mg_school_id, object)
      return email.save
    rescue Exception => e
      puts e
      return false
    end
  end





	def exam_hall_ticket
	  @academic_name=MgTimeTable.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id]).pluck(:name,:id)
	  @programme_name=MgWing.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:created_by=>session[:user_id],:updated_by=>session[:user_id]).pluck(:wing_name,:id)
	  #render :layout=>false
	end

	def select_wing
	  @exam=MgExaminationDetail.find_by(:id=>params[:mg_examination_detail_id])
	  @course_id=MgExaminationTimeTable.where(:is_deleted=>0, :mg_school_id=>session[:current_user_school_id], :mg_examination_detail_id=>params[:mg_examination_detail_id],:mg_wing_id=>params[:wing_id]).pluck(:mg_course_id)
	  # @course_id = MgCourse.where(:mg_wing_id=>params[:wing_id],:is_deleted=>0,:mg_school_id=>session[:current_user_school_id]).pluck(:id)
	  @academic_name = MgTimeTable.find_by(:id=>params[:academig_year_id])
	  # @batch_list =MgBatch.where("is_deleted=? and mg_school_id=?",0,session[:current_user_school_id])
	  @batch_list =MgBatch.where("start_date >=? and end_date <=? and is_deleted=? and mg_school_id=?",@academic_name.start_date,@academic_name.end_date,0,session[:current_user_school_id])
	  
	  @batch_id = @batch_list.where("mg_course_id IN (?)",@course_id)
	 # @batch_id=MgBatch.where(:mg_wing_id=>params[:wing_id],:is_deleted=>0,:mg_school_id=>session[:current_user_school_id])
	  render :layout=>false
	end

	def batch_wise_students
	  @mg_student = MgStudent.where(:mg_batch_id=>params[:batch_id],:is_deleted=>0,:mg_school_id=>session[:current_user_school_id])
	  params[:mg_examination_detail_id]=params[:mg_examination_detail_id]
	  render :layout=>false
	end

	def mg_student_show
	  @student = MgStudent.find(params[:id])

	  @studentUserId= @student.mg_user_id
	  @studentCategoryId= @student.mg_student_catagory_id

	  @address=MgAddress.where(mg_user_id: @studentUserId)
	  puts @address.inspect
	  @contact=MgPhone.where(mg_user_id: @studentUserId)
	  @email=MgEmail.where(mg_user_id: @studentUserId)
	  @studentCategory=MgStudentCategory.where(id: @studentCategoryId)

	  @dbdatas = MgCommonCustomField.where(model_name: "student",is_deleted:0,mg_school_id:session[:current_user_school_id])
	  @customData = MgCustomFieldsData.where(mg_user_id:@student.mg_user_id,is_deleted:0,mg_school_id:session[:current_user_school_id])
	  @previous_education=MgPreviousEducation.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_student_id=>@student.id)
	end

	def hall_ticket_pdf
	 	
	  @student_obj=MgStudent.find_by(:id=>params[:id])
	  #@exam_detail = MgEntranceExamDetail.find_by(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_course_id=>params[:mg_id])
	  
	  @course=MgBatch.find_by(:id=>@student_obj.mg_batch_id)
	  @course_name = MgCourse.find_by(:id=>@course.mg_course_id)

	  @school=MgSchool.find(session[:current_user_school_id])
	  @school_logo=@school.logo.url(:medium,:timestamp=>false)
	  @date_format = MgSchool.find_by(:id=>session[:current_user_school_id]).date_format

	    respond_to do |format|
	    format.html
	    format.pdf do
	      pdf = StudentHallTicketPdf.new(@student_obj,@course_name,@school_logo,@school,@date_format, params[:mg_examination_detail_id])
	      
	      send_data pdf.render, filename: 
	      "mindcom_hall_ticket_#{DateTime.now.strftime(@date_format)}.pdf",
	      type: "application/pdf", :disposition => 'inline'
	    end
	  end
	end

	def exam_admit_card
	  	puts inspect
      # puts kljasdfl;	  	
	    @student_id_array = params[:mg_student_ids]
	    @session_id = session[:current_user_school_id] 
	    
	    if @student_id_array.present?
	      @student_id_array.each do |stu_id|

	        @student_obj=MgStudent.find_by(:id=>stu_id)
	        #@exam_detail = MgEntranceExamDetail.find_by(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id] ,:mg_course_id=>@student_name.mg_course_id)
	        @course_name = MgCourse.find_by(:id=>@student_obj.mg_course_id, :is_deleted=>0,:mg_school_id=>session[:current_user_school_id])
	        @school=MgSchool.find_by(:id=>session[:current_user_school_id] )
	        @school_logo=@school.logo.url(:medium,:timestamp=>false)
	        @date_format = MgSchool.find_by(:id=>session[:current_user_school_id] ).date_format 

	        respond_to do |format|
	          format.html
	          format.pdf do
	            pdf = StudentHallTicketPdf.new(@student_obj,@course_name,@school_logo,@school,@date_format, params[:mg_examination_detail_id])
	            pdf.render_file File.join(Rails.root, "public/student_hall_ticket", "hall_ticket#{stu_id}.pdf")                        
	          end
	        end
	         NotificationMailer.send_mail_to_mgstudent(stu_id,@session_id, params[:mg_examination_detail_id]).deliver
	         #@student_obj.update(:hall_ticket_release=>1)        
	      end
	      redirect_to :controller=>'exam_management',:action=>'exam_hall_ticket', :academig_year_id=>params[:academig_year_id], :programme_ids=>params[:programme_ids],:select_batch=>params[:select_batch], :mg_examination_detail_id=>params[:mg_examination_detail_id]
	    else
	      redirect_to :controller=>'exam_management',:action=>'exam_hall_ticket' , :params=>{:academig_year_id=>params[:academig_year_id], :programme_ids=>params[:programme_ids], :mg_examination_detail_id=>params[:mg_examination_detail_id]}	    	
	    end   
	end 

#Bindhu Added for Sorting employee starts
  def department_wise_employee
    @invigilators = MgInvigilator.find(params[:mg_inviligators_id])
    if params[:mg_department_id]==""
      employee=MgEmployee.where(:id=>@invigilators.mg_invigilator_details.where(:is_deleted=>0).pluck(:mg_employee_id), :is_deleted=>0, :mg_school_id=>session[:current_user_school_id])
    else
      employee=MgEmployee.where(:mg_employee_department_id=>params[:mg_department_id],:id=>@invigilators.mg_invigilator_details.where(:is_deleted=>0).pluck(:mg_employee_id), :is_deleted=>0, :mg_school_id=>session[:current_user_school_id])
    end
    @employee=""
    employee.order(:first_name, :last_name).each do |s|
      @employee+= "#{s.try(:first_name)} #{s.try(:last_name)} (#{s.try(:employee_number)})" 
      @employee+=","
    end
    strlength=@employee.length
    @reqStr=@employee.slice(0,strlength-1)
    respond_to do |format|
      format.json  { render :json =>@reqStr.to_json}
    end
  end
#Bindhu Added for Sorting employee ends
  def subject_specialization
      mg_school_id=session[:current_user_school_id]
      # @examination_hod_logins=MdgExaminationHodLogin.find_by(:mg_user_id=>session[:user_id])
      examination_hod_logins=MgExaminationHodLogin.find_by(:mg_user_id=>session[:user_id])
      employee=MgEmployee.find_by(:id=>examination_hod_logins.mg_employee_id)
      subject=MgSubject.where(:is_deleted=>0, :mg_school_id=>mg_school_id, :mg_employee_specialization_id=>employee.hod_specialization_id)
      @subject_specialization=MgExamSubjectSpecializedEmployees.where(:is_deleted => 0, :mg_school_id=>session[:current_user_school_id], :mg_subject_id=>subject.pluck(:id)).paginate(page: params[:page], per_page: 10)
    
  end

  def new_subject_specialization
    @subject_specialization=MgExamSubjectSpecializedEmployees.new
    # @time_table=MgExaminationTimeTable.new
      # @examination_hod_logins=MdgExaminationHodLogin.find_by(:mg_user_id=>session[:user_id])
      
      @exam_types=MgExamType.where(:is_deleted=>0, :mg_school_id=>session[:current_user_school_id]).pluck(:name, :id)
      @examination_category=MgExaminationCategory.where(:is_deleted=>0, :mg_school_id=>session[:current_user_school_id]).pluck(:name, :id)
      @acadimic_year=MgTimeTable.where(:is_deleted=>0, :mg_school_id=>session[:current_user_school_id]).pluck(:name, :id)
      @wing=MgWing.where(:is_deleted=>0, :mg_school_id=>session[:current_user_school_id]).pluck(:wing_name, :id)
      @examination_program_category=MgExaminationProgramCategory.where(:is_deleted=>0, :mg_school_id=>session[:current_user_school_id]).pluck(:name, :id)
      @course=MgCourse.where(:is_deleted=>0, :mg_school_id=>session[:current_user_school_id]).pluck(:course_name, :id)
      
  end
  def edit_subject_specialization
    mg_school_id=session[:current_user_school_id]
    @subject_specialization=MgExamSubjectSpecializedEmployees.find(params[:id])
    @subject=MgSubject.where(:is_deleted=>0, :mg_school_id=>session[:current_user_school_id])
    puts @subject_specialization.inspect
    subject=MgSubject.where(:is_deleted=>0, :mg_school_id=>mg_school_id, :id=>@subject_specialization.mg_subject_id)
      # mg_employee_specialization_id
      particular_specialization=MgParticularSpecialization.where(:is_deleted=>0, :mg_school_id=>mg_school_id,:mg_employee_specialization_id=>subject.pluck(:mg_employee_specialization_id)).pluck(:mg_employee_id)
      @employee=MgEmployee.where(:is_deleted=>0, :mg_school_id=>mg_school_id, :id=>particular_specialization)
      # str=[]
      # employee.each do |a|
      #    str.push({:name=>"#{a.first_name.try(:titleize)} #{a.last_name.try(:titleize)} (#{a.employee_number})", :id=>a.id})
      # end
      # @object=str
      # puts str.inspect
  end
  def show_subject_specialization
    @subject_specialization=MgExamSubjectSpecializedEmployees.find(params[:id])
    puts @subject_specialization.inspect
    render :layout=>false

  end
  def delete_subject_specialization
    @subject_specialization=MgExamSubjectSpecializedEmployees.find(params[:id])
    @subject_specialization.is_deleted=1

    respond_to do |format|
      format.json  { render :json =>@subject_specialization.save}
    end
  end
  def update_subject_specialization
     @subject_specialization=MgExamSubjectSpecializedEmployees.find(params[:id])
      if @subject_specialization.update(subject_specialization_params)
        flash[:notice]="Updated successfully"
      else
        flash[:error]="Not updated successfully. Error occured, please contact administrator "
      end
      redirect_to :action=>'subject_specialization'
  end
  def create_subject_specialization
    @subject_specialization=MgExamSubjectSpecializedEmployees.new(subject_specialization_params)
      if @subject_specialization.save
        flash[:notice]="Created successfully"
      else
        flash[:error]="Not created successfully. Error occured, please contact administrator "
      end
      redirect_to :action=>'subject_specialization'
  end

  def subject_specialization_details

   @subject_specialization=MgExamSubjectSpecializedEmployees.where(:is_deleted=>0, :mg_school_id=>session[:current_user_school_id]).paginate(page: params[:page], per_page: 10)
  end

  private
  def examination_category_params
    params.require(:examination_category).permit(:name, :description, :is_deleted, :mg_school_id, :created_by, :updated_by)
  end

  def exam_types_params
    params.require(:exam_types).permit(:name, :description, :is_deleted, :mg_school_id, :created_by, :updated_by)
  end

  def examination_params
  	# :start_date, :end_date,
    params.require(:examination).permit(:name,:mg_examination_program_category_id,:mg_examination_category_id, :mg_course_id, :mg_batch_id,:mg_exam_type_id, :description, :mg_examination_category_id,:mg_time_table_id, :mg_wing_id,:is_deleted, :mg_school_id, :created_by, :updated_by)
  end

  def exam_management_program_category
    params.require(:exam_management_data).permit(:name, :description, :is_deleted)
  end

  def invigilators_params
    params.require(:invigilators).permit(:date, :time, :mg_subject_id, :no_of_invigilators, :is_deleted, :mg_school_id, :created_by, :updated_by)
  end

  def time_table_params
  	 params.require(:time_table).permit(:mg_batch_id,:mg_course_id, :mg_wing_id, :max_marks, :mg_subject_id, :pass_marks, :start_time, :end_time, :date,:mg_examination_detail_id, :is_deleted, :mg_school_id, :created_by, :updated_by)
  end
  def seating_plan_params
  	 params.require(:seating_plan).permit(:mg_employee_specialization_id, :mg_institute_room_id, :total_seats, :seat_available,:mg_examination_detail_id, :is_deleted, :mg_school_id, :created_by, :updated_by)
  end
def params_user
    params.require(:financial_manager).permit(:is_deleted,:mg_school_id,:created_by,:updated_by,:user_type,:user_name,:password)
  end
def password_params
    params.require(:financial_manager).permit(:password)
  end
  def store_manager_login_params
    params.require(:store_manager).permit(:is_deleted,:mg_school_id,:created_by,:updated_by,:user_type,:user_name,:password)
  end
  def store_manager_password_params
    params.require(:store_manager).permit(:password)
  end

  def subject_specialization_params
    params.require(:subject_specialization).permit(:mg_examination_detail_id,:mg_employee_id,:mg_subject_id, :mg_school_id, :is_deleted,:created_by,:updated_by)
  end  

  def subject_params
    params.require(:transport_fees).permit(:name,:description,:is_deleted, :mg_school_id)
  end

   def particular_params
    params.require(:fesses2).permit(:mg_particular_type_id,:description,:fee_category,:is_deleted, :mg_school_id,:amount,
     :admission_no)
  end
  def update_particular_params
    params.require(:fesses2).permit(:name,:description,:fee_category,:is_deleted, :mg_school_id,:amount, :admission_no, :mg_student_category_id)
  end
  def grade_params
    params.require(:grades).permit(:name,:mg_batch_id,:min_score,:order,:credit_points,:description,:is_deleted,:mg_school_id)
  end
  def update_params
    params.require(:grades).permit(:name,:min_score,:order,:credit_points,:description,:is_deleted,:mg_school_id)
  end
end
