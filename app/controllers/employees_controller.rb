class EmployeesController < ApplicationController

  # comment replace  hello from
    before_filter :login_required
  layout "mindcom"


  def search_employee_data
      @employeeList = MgEmployee.where("first_name LIKE :fname OR last_name LIKE :lname",{:fname => "%#{params[:searchData]}%",:lname => "%#{params[:searchData]}%"})


      respond_to do |format|
        format.json  { render :json => @employeeList }
      end
    
  end

  def assign_class_teacher_to_batch_create
    puts params[:cls_teacher]

    @batch = MgBatch.find(params[:cls_teacher][:mg_batch_id])
    # @batch.mg_employee_id = params[:cls_teacher][:emp_id]
    puts "Step --@batch.inspec "
    puts @batch.inspect
    puts "Step -- @batch.inspect "

    emp_id = params[:cls_teacher][:emp_id]

    puts "Step --@batch.inspec "
    puts emp_id
    puts "Step -- @batch.inspect "
        @batch.update(:mg_employee_id => emp_id[0].to_i)

    puts "Step --@batch.inspec "
    puts @batch.inspect
    puts "Step -- @batch.inspect "
    redirect_to :action=>'assign_class_teacher_to_batch'

  end

  def assign_class_teacher_to_batch
    
  end


  def validate_accout_no
    puts params[:account_number]


    object=MgBankAccountDetail.where(:is_deleted=>0, :mg_school_id=>session[:current_user_school_id], :account_number=>params[:account_number])



    respond_to do |format|
            format.json  { render :json => {'validation'=> object.present? } }
    end
  end

  def employee_list_according_to_category
    @presentEmployeeId=MgBatch.where(:id=>params[:mg_batch_id]).pluck(:mg_employee_id)
      employee_list=MgParticularSpecialization.where(:is_deleted=>0, :mg_school_id=>session[:current_user_school_id], :mg_employee_specialization_id=>params[:mg_employee_specialization_id]).pluck(:mg_employee_id)
      puts "employee_list----> #{employee_list.inspect}"
   @classTeacher=""
    if(@presentEmployeeId[0].to_s.empty?)
      @classTeacher="Not Assigned"
    else
      @classTeacher=MgEmployee.where(:id=> @presentEmployeeId,:mg_employee_category_id=>1)
      
      puts "spec"
      # puts @specilization.inspect
      # puts lll
    end

    @alreadyAssignedEmployeeId=MgBatch.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id]).pluck(:mg_employee_id).compact
    puts "Employee Present"
    puts @alreadyAssignedEmployeeId
    puts "Employee List"
    
    # @alreadyAssignedEmployeeId = nil
    principal_user_id=MgUser.where(:user_type=>"principal",:mg_school_id=>session[:current_user_school_id]).pluck(:id)
    # principal_user_id.push(@presentEmployeeId)
    if principal_user_id.present?
      @positionList = MgEmployee.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:id=>employee_list,:mg_employee_category_id=>1).where('mg_user_id not in (?)',principal_user_id).all
      if @alreadyAssignedEmployeeId.present?
        @positionList = MgEmployee.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:id=>employee_list,:mg_employee_category_id=>1).where('id not in (?)',@alreadyAssignedEmployeeId).where('mg_user_id not in (?)',principal_user_id).all
        
      end
    else
      @positionList = MgEmployee.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:id=>employee_list,:mg_employee_category_id=>1).all
      if @alreadyAssignedEmployeeId.present?
      @positionList = MgEmployee.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:id=>employee_list,:mg_employee_category_id=>1).where('id not in (?)',@alreadyAssignedEmployeeId).all
      
      end

    end

    employe=MgEmployee.where(:is_deleted=>0, :mg_school_id=>session[:current_user_school_id])
    employe_spl_hash=Hash.new
    employe.each do |employe_loop|
      e_spl=[]
      p_spl=MgParticularSpecialization.where(:is_deleted=>0, :mg_school_id=>session[:current_user_school_id], :mg_employee_id=>employe_loop.id).pluck(:mg_employee_specialization_id)
      e_spl=MgEmployeeSpecialization.where(:is_deleted=>0, :mg_school_id=>session[:current_user_school_id], :id=>p_spl).pluck(:name)
      employe_spl_hash[employe_loop.id]=e_spl.join(", ")
    end
    puts employe_spl_hash.inspect
    # puts jherojojo

      puts "checking employee List"
      puts @positionList.size

      respond_to do |format|
        format.json  { render :json => [@positionList,@classTeacher, employe_spl_hash] }
      end
    
  end

  def employee_position_list
      @sql = "Select id,position_name from mg_employee_positions where mg_employee_category_id = #{params[:id]} and is_deleted = '0' and mg_school_id = #{session[:current_user_school_id]} "
      @positionList = MgEmployeePosition.find_by_sql(@sql)

      respond_to do |format|
        format.json  { render :json => @positionList }
      end
  end

  def edit_contact_by_employee
    @employee=MgEmployee.find(params[:id])

      @phone = MgPhone.find_by(:mg_user_id => @employee.mg_user_id, :phone_type => 'phone')
      @mobile = MgPhone.find_by(:mg_user_id => @employee.mg_user_id, :phone_type => 'mobile')

      @email = MgEmail.find_by(:mg_user_id => @employee.mg_user_id, :email_type => 'home')

      @phone.update(emergency_phone_params)
      @mobile.update(personal_phone_params)
      @email.update(email_params)

    redirect_to '/dashboards/employee_profile/'
    
  end
  def edit_address_by_employee
    @employee=MgEmployee.find(params[:id])
    @Permanent=MgAddress.find_by(:mg_user_id=>@employee.mg_user_id, :address_type=>"Permanent")

    @Permanent.update(permanent_address_params)

    redirect_to '/dashboards/employee_profile/'

    
  end
  def edit_crrespondance_address_by_employee
    @employee=MgEmployee.find(params[:id])
    @Permanent=MgAddress.find_by(:mg_user_id=>@employee.mg_user_id, :address_type=>'Temporary')

    @Permanent.update(temporary_address_params)

    redirect_to '/dashboards/employee_profile/'
  end



  def manage_employees
    puts "Step -- 1"
    @employee_list=MgEmployee.all
    puts "Step -- 1"
    render :layout => false
  end

    def index
    #  @mg_employee_category = MgEmployeeCategory.new
    #for chartkick 

      
      @employeeDepartment=MgEmployeeDepartment.where(:is_deleted=>0, :mg_school_id=>session[:current_user_school_id])
      #@employees = MgEmployee.where(:mg_employee_department_id=>'12')


      #Added by Bindhu
      principal_ids=MgUser.where(:user_type=>"principal").pluck(:id)
      #@employees = MgEmployee.where(:is_deleted => '0', :mg_school_id=>session[:current_user_school_id]).paginate(page: params[:page], per_page: 10)
      @employees = MgEmployee.where(:is_deleted => '0', :mg_school_id=>session[:current_user_school_id]).where("id != ?", 1).paginate(page: params[:page], per_page: 10)
             #@art = MgEmpCategory.count(:condition => { :prefix => "driver" }) 
    end

    def new 

      

     
     
      @employee = MgEmployee.new
      find_data = MgEmployee.first
     
      @languageList = MgLanguage.where(mg_user_id:@employee.mg_user_id,is_deleted:0,mg_school_id:session[:current_user_school_id])

      @dbdatas = MgCommonCustomField.where(model_name: "employee",is_deleted:0,mg_school_id:session[:current_user_school_id])
      @account_details=MgBankAccountDetail.new

    end
    #==========================================creating-=======================================================
    def syllabus_tracker_create
      @tracker=MgSyllabusTracker.new(syllabus_track_create_param)
      @tracker.save
      @timeformat = MgSchool.find(session[:current_user_school_id])
          if @timeformat.present?
          @date = Date.strptime(params[:syllabus][:date],@timeformat.date_format)
          @tracker.update(:date =>@date)
end
      
      redirect_to :action=>"syllabus_tracker_show"
      
    end



    def tracker_edit


      @syllabus = MgSyllabusTracker.find(params[:id])
      @curriculum = MgSyllabusTracker.find(params[:id])
      
    end

    def tracker_update
      @syllabus = MgSyllabusTracker.find(params[:id])
     
      if @syllabus.update(track_update_param)
         @syllabus.update(:mg_subject_id=>params[:mg_subject_id],:mg_syllabus_id=>params[:mg_syllabus_id],:mg_unit_id=>params[:mg_unit_id],:mg_topic_id=>params[:mg_topic_id])
          @timeformat = MgSchool.find(session[:current_user_school_id])
        if @timeformat.present?
          @date = Date.strptime(params[:syllabus][:date],@timeformat.date_format)
          @syllabus.update(:date =>@date)
        end
        redirect_to :action => "syllabus_tracker_show"
      else
        render 'tracker_edit'
      end
      
    end

    def tracker_delete

      @syllabus = MgSyllabusTracker.find(params[:id])
      
      if @syllabus.update(:is_deleted => 1)
        render 'syllabus_tracker_show'
        else
      
      end
      
    end


    def syllabus_track
      if params[:short_class_type_wise].present?
              if params[:short_class_type_wise][:class_type].present?
                @value=params[:short_class_type_wise][:class_type]
              else
                @value=0
              end
          else
              @value=0
          end
          if  @value!=0
              @id=params[:short_class_type_wise][:class_type]
          #@employees = MgEmployee.where(:mg_unit_id=>params[:short_unit_wise][:mg_unit_id],:is_deleted => 0,:mg_employee_category_id=>1,:mg_school_id=>session[:current_user_school_id]).paginate(page: params[:page], per_page: 10)  
          else
            @id="Theory"
            puts "first time to the graph"
          #@employees = MgEmployee.where(:is_deleted => 0,:mg_employee_category_id=>1,:mg_school_id=>session[:current_user_school_id]).paginate(page: params[:page], per_page: 10) 
          end
    end
    #=======================================================================================================
 


    def create
      mg_school_id=session[:current_user_school_id]
      created_by=session[:user_id]
      #puts params.require(:employee).permit(:employee_category_id, :employee_number, :joining_date, :first_name, :middle_name, :last_name, :gender, :job_title, :employee_position_id, :employee_department_id, :reporting_manager_id, :employee_grade_id, :qualification, :experience_detail, :experience_year, :experience_month, :status, :status_description_string, :date_of_birth, :marital_status, :children_count, :father_name, :mother_name, :husband_name, :blood_group, :nationality_id, :home_city, :home_state, :home_country_id, :employee_position_id, :home_pin_code, :photo_file_name, :photo_content_type, :photo_data, :photo_file_size, :user_id, :school_id, :is_deleted)
     begin
    MgUser.transaction do
      @school_sub_domain=MgSchool.find(session[:current_user_school_id])
              if params[:employee][:user_type]=="principal" || params[:employee][:user_type]=="admin" || params[:employee][:user_type]=="superprincipal"

                      if MgEmployee.where(:mg_school_id=>params[:employee][:mg_school_id]).count.zero? # empty array
                            @strVal='1'   
                      else
                            @lastrecord = MgEmployee.where(:mg_school_id=>params[:employee][:mg_school_id]).last
                            str=@lastrecord.employee_number
                            @sub=params[:employee][:mg_school_id]
                            school_id_sub=MgSchool.find(@sub)
                            m=school_id_sub.subdomain.length
                            n= str.length
                            tail= str.slice(m+1, n)
                            @lastrecord=tail
                            @lastadmissionId= @lastrecord.to_i
                            @nextAdmissionNumber = @lastadmissionId + 1;
                            @strVal = @nextAdmissionNumber.to_s
                      end
              else

                      if MgEmployee.where(:mg_school_id=>params[:employee][:mg_school_id]).count.zero? # empty array
                          @strVal='1'
                      else
                          @lastrecord = MgEmployee.where(:mg_school_id=>params[:employee][:mg_school_id]).last
                          str=@lastrecord.employee_number
                          m=@school_sub_domain.subdomain.length
                          n= str.length
                          tail= str.slice(m+1, n)
                          @lastrecord=tail
                          @lastadmissionId= @lastrecord.to_i
                          @nextAdmissionNumber = @lastadmissionId + 1;
                          @strVal = @nextAdmissionNumber.to_s
                      end
              end
  #create user name
   
  #end here



      @user = MgUser.new(employee_user_params)
       if params[:employee][:user_type]=="principal" || params[:employee][:user_type]=="admin" || params[:employee][:user_type]=="superprincipal"
        @ids=params[:employee][:mg_school_id]
        puts @ids.inspect
        school_id=MgSchool.find(@ids)

      @user.user_name="#{school_id.subdomain}#{"E"}#{@strVal}"
    else
            @user.user_name="#{@school_sub_domain.subdomain}#{"E"}#{@strVal}"

    end
      
      @temporary_address = @user.mg_addresses.build(temporary_address_params)
      @permanent_address = @user.mg_addresses.build(permanent_address_params)

      # Contact Number Work

      @emergency_phone = @user.mg_phones.build(emergency_phone_params)
      @personal_phone = @user.mg_phones.build(personal_phone_params)

      # E-mail Work

      @personal_email = @user.mg_emails.build(email_params)
      

      # Employee Work
      @employee = @user.mg_employees.build(employees_params)
      # payscale=params[:employee][:pay_scale]
      type="create"
      #payscale create method start from here
        # create_employee_payslip(payscale,@employee, mg_school_id,created_by,created_by, type)
        create_employee_grade_component(@employee,mg_school_id,created_by,created_by,params[:employee][:mg_employee_grade_id] )


      #payscale create method end
      #accout_dtails start
         @account_details=@employee.mg_bank_account_details.build(account_details_params)
         # @account_details.mg_employee_id=@employee# = @user.mg_employees.mg_bank_account_details.build(account_details_params)
         @account_details.mg_school_id=mg_school_id
         @account_details.created_by=created_by
         @account_details.updated_by=created_by
         @account_details.is_deleted=0

         @account_details.save
      #accout_dtails end


      if params[:employee][:user_type]=="principal" || params[:employee][:user_type]=="admin" || params[:employee][:user_type]=="superprincipal"
        @id=params[:employee][:mg_school_id]
        school_ids=MgSchool.find(@id)
      @employee.employee_number= "#{school_ids.subdomain}#{"E"}#{@strVal}"

    else
      @employee.employee_number= "#{@school_sub_domain.subdomain}#{"E"}#{@strVal}"
    end
if params[:employee][:user_type]=="superprincipal"
        role_id=MgRole.where(:role_name=>'superprincipal')
          @user_role = @user.mg_user_roles.build( :mg_role_id => role_id[0].id.to_i)
       elsif params[:employee][:user_type]=="admin"
        role_id=MgRole.where(:role_name=>'admin')
          @user_role = @user.mg_user_roles.build( :mg_role_id =>  role_id[0].id.to_i)
       elsif params[:employee][:user_type]=="principal"
        role_id=MgRole.where(:role_name=>'principal')
          @user_role = @user.mg_user_roles.build( :mg_role_id =>  role_id[0].id.to_i)
       else
        role_id=MgRole.where(:role_name=>'employee')

          @user_role = @user.mg_user_roles.build( :mg_role_id => role_id[0].id.to_i)
       end
    

   #   @employee.save

       
       @user_role.save 


      ############################ customdata

      
            
      

  #    respond_to do |format|
    if @user.save


      
       # if true

      # Language work start

      langArr = params[:language][:language_name]
      readArr =  params[:language][:read]
      writeArr =  params[:language][:write]
      speakArr =  params[:language][:speak]


      unless langArr.nil? || langArr == 0

        langArr.each do |langName|
          puts " ---------------------Step -- 1 -------------------     "
          if langName.length > 0
            # iterate read Array and create new object lang-name is langName

            @language = MgLanguage.new
            @language.language_name = langName
            @language.mg_user_id = @user.id
            @language.is_deleted = 0
            @language.mg_school_id = session[:current_user_school_id]
              @language.save

        
            unless readArr.nil? || readArr == 0

              readArr.each do |readLang|

                if readLang.include? langName
                  puts "------------------Read Lang -------------------------------------"
                  readSplt =  readLang.split("$")
                  readStandard = readSplt[1]
                  @language.update(:read=>readStandard.to_s)
                  puts "------------------Read Lang -------------------------------------" +readStandard
              end
              end
              
            end

            unless writeArr.nil? || writeArr == 0

              writeArr.each do |writeLang|

                if writeLang.include? langName
                  puts "------------------write Lang -------------------------------------"
                  writeSplt =  writeLang.split("$")
                  writeStandard = writeSplt[1]

                  @language.update(:write=>writeStandard.to_s)
                  puts "------------------write Lang -------------------------------------" +writeStandard
              end
              end
            end


          unless speakArr.nil? || speakArr == 0
            # ...
              speakArr.each do |speakLang|

                if speakLang.include? langName
                  puts "------------------speak Lang -------------------------------------"
                  speakSplt =  speakLang.split("$")
                  speakStandard = speakSplt[1]
                  @language.update(:speak=>speakStandard.to_s)
                  puts "------------------speak Lang -------------------------------------" +speakStandard
              end
              end
          end

          end
        end
      end


          @isUserSave=@employee.save
        if params[:employee_hod_specialization].present?
          @employee.update(:hod_specialization_id=>params[:employee_hod_specialization])
        end
         
          @temporary_address.save
          @permanent_address.save
          @emergency_phone.save
          @personal_phone.save
          @personal_email.save
 
          if params[:selectedEmployeeSpecialization].present?
            @params=params[:selectedEmployeeSpecialization]
      for j in 0...@params.size
        @specialization=MgParticularSpecialization.new()
        @specialization.mg_employee_id=@employee.id
        @specialization.mg_employee_specialization_id=@params[j]
        @specialization.is_deleted=0
        @specialization.mg_school_id=session[:current_user_school_id]
        @specialization.created_by=session[:user_id]
        @specialization.updated_by=session[:user_id]
        @specialization.save
      end
          end
    #create user name


    #end here



          @timeformat = MgSchool.find(session[:current_user_school_id])
          if @timeformat.present?
                @joiningDate = Date.strptime(params[:employee][:joining_date],@timeformat.date_format)
                puts "Date Of Birth is ===="
                @dateOfBirth = Date.strptime(params[:employee][:date_of_birth],@timeformat.date_format)
                if params[:employee][:last_working_day].present?
                last_working_day = Date.strptime(params[:employee][:last_working_day],@timeformat.date_format)
                @employee.update(:joining_date => @joiningDate,:date_of_birth => @dateOfBirth,:last_working_day => last_working_day)
                else
                @employee.update(:joining_date => @joiningDate,:date_of_birth => @dateOfBirth)

                end
                 puts "Date Of Birth is updating===="
          end

          @employee.update(:is_referred=>params[:referred][:is_referred],
            :referred_by=>params[:referred][:referred_emp_name],
           :designation=>params[:referred][:emp_designation])

          #For Mg Employee Leaves Added By Bindhu Start
          # leave_types=MgEmployeeLeaveType.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id])
          puts "Employee Id"
          puts @employee.id
          # if (@employee.gender=="male")
            leave_types=MgEmployeeLeaveType.where("is_deleted=0 AND mg_school_id=? AND minimum_month_experience <= ?+?+TIMESTAMPDIFF(MONTH, ?, CURDATE()) And gender in(?,?) AND marital_status in(?,?) ",session[:current_user_school_id],@employee.experience_year*12,@employee.experience_month,@employee.joining_date,@employee.gender,'all', 'all',(@employee.marital_status? ? @employee.marital_status : '') )
            # puts "leave_type length"
            # puts leave_types.count
          # else 
            # leave_types=MgEmployeeLeaveType.where("is_deleted=0 AND mg_school_id=? AND minimum_month_experience <= ?+?+TIMESTAMPDIFF(MONTH, ?, CURDATE()) And gender in('female','all')",session[:current_user_school_id],@employee.experience_year*12,@employee.experience_month,@employee.joining_date)
            # puts "leave_type length"
            # puts leave_types.count
          # end

          leave_types.each do |leave_type|
            employee_leaves=MgEmployeeLeaves.new
            employee_leaves.mg_employee_id=@employee.id
            employee_leaves.mg_leave_type_id=leave_type.id
            employee_leaves.leave_taken=0
            employee_leaves.mg_school_id=session[:current_user_school_id]
            employee_leaves.is_deleted=0
            employee_leaves.available_leave=leave_type.max_leave_count
            employee_leaves.leave_month_year=Date.today

            employee_leaves.save
          end
          #For Mg Employee Leaves Added By Bindhu End


           if params[:employee][:user_type]=="superprincipal"

            #Add Entry in multiple school access employee
              new_multi_school_access_obj=MgMultiSchoolAccess.new(:mg_school_id=>params[:employee][:mg_school_id],
               :mg_user_id=>@user.id, :is_deleted=>0, 
               :created_by=>session[:user_id], :updated_by=>session[:user_id])
              new_multi_school_access_obj.save
            #End here

              redirect_to :controller=>'cloud_admins', :action=>'show_super_principal'

           elsif params[:employee][:user_type]=="admin"
              redirect_to :controller=>'cloud_admins', :action=>'admin_index'
           elsif params[:employee][:user_type]=="principal"
              redirect_to :controller=>'cloud_admins', :action=>'principal_index'
           else
              redirect_to '/employees'
           end
           
        else
          puts "Inside User Not save"
          #@employee = MgEmployee.new
          #find_data = MgEmployee.first
      #for chartkick object



          # @languageList = MgLanguage.where(mg_user_id:@employee.mg_user_id)
          # @dbdatas = MgCommonCustomField.where(model_name: "employee",is_deleted:0,mg_school_id:session[:current_user_school_id])


          # if MgEmployee.count.zero? # empty array
          #   @strVal='1'
          # else
          #   @lastrecord = MgEmployee.last
          #   @lastadmissionId= @lastrecord.id.to_i
          #   @nextAdmissionNumber = @lastadmissionId + 1;
          #   @strVal = @nextAdmissionNumber.to_s
          # end

          #render 'new'

          if params[:employee][:user_type]=="superprincipal"
              redirect_to :controller=>'cloud_admins', :action=>'super_principal'
          elsif params[:employee][:user_type]=="admin"
              redirect_to :controller=>'cloud_admins', :action=>'new_admin'
          elsif params[:employee][:user_type]=="principal"
              redirect_to :controller=>'cloud_admins', :action=>'principal_index'
          else
              render 'new'
          end

        end

    @custFieldNameIds = params[:custom_data]
      if  @custFieldNameIds.nil?
           else
              for j in 0...@custFieldNameIds.size
           
                  @custFieldValObj = params[:"custom_field_#{@custFieldNameIds[j]}"]

                @custFieldVal = nil
              if !@custFieldValObj.nil? && @custFieldValObj.size>0
                

                    @custFieldVal =@custFieldValObj[0];

                    for index in 1...@custFieldValObj.size 
                      @custFieldVal << ','+@custFieldValObj[index]

                    end 
                  end   

                  @savedetails=MgCustomFieldsData.new(save_params) 
                    @savedetails.value=@custFieldVal
                    @savedetails.mg_custom_field_id=@custFieldNameIds[j]
                    @savedetails.mg_user_id = @user.id
                    @savedetails.is_deleted=0
                    @savedetails.save
              
          
            end
      end
require 'open-uri'
            
            @file=params[:file]
           # @fileupload.file=params[:file]
            if @file.nil?
            else
              @file.each do |a|
                 @fileupload=MgDocumentManagement.new()
            
                 @fileupload.file=a
                 puts @employee.mg_user_id
                 @fileupload.document_type="SportsActivity"
                 @fileupload.mg_user_id=@employee.mg_user_id
              
                 @fileupload.save
                
            end
          
          end
          
          @files=params[:files]
          puts params[:files].inspect
           # @fileupload.file=params[:file]
           puts "hello"
           puts params[:files].inspect
           if @files.nil?
           else
             @files.each do |a|
               @fileupload=MgDocumentManagement.new()
              
               @fileupload.file=a
            
               @fileupload.document_type="ExtraCurricular"
               @fileupload.mg_user_id=@employee.mg_user_id
          
               @fileupload.save
            
             end
          
          end
      #end
    end


rescue
    flash[:error]="Error occured, please contact administrator"
    redirect_to :action=>'new'
 end
  end


  def create_employee_grade_component(employee,mg_school_id,created_by,updated_by,mg_employee_grade_id )
    # employe.emg_employee_grade_components.build()  , :is_applicable=>1
      grade_component=MgGradeComponent.where(:is_deleted=>0, :mg_school_id=>mg_school_id, :mg_employee_grade_id=>mg_employee_grade_id, :is_applicable=>1)
      grade_component.each do |component| 
        employee.mg_employee_grade_components.build(:is_deleted=>0, :mg_school_id=>mg_school_id, :mg_salary_component_id=>component.mg_salary_component_id, :amount=>component.amount, :created_by=>created_by,:updated_by=>created_by, :is_edited=>0)
      end
    
  end


  def create_employee_payslip(payscale,employee, mg_school_id,created_by, updated_by, type)
    if type=='create'
    employee.mg_employee_payslips.build(:payscale=>payscale, :is_deleted=>0, :from_date=>Date.today, :mg_school_id=>mg_school_id, :created_by=>created_by, :updated_by=>updated_by)
    elsif type=='delete'
      from_date_obj=MgEmployeePayslip.where(:is_deleted=>0, :mg_employee_id=>employee.id, :mg_school_id=>mg_school_id)
      from_date_obj.each do |delete|
      delete.update(:is_deleted=>1)
      end
    else
      from_date_obj=MgEmployeePayslip.where(:is_deleted=>0, :mg_employee_id=>employee.id, :mg_school_id=>mg_school_id).last
       to_date=nil
      if from_date_obj.present?
       if from_date_obj.to_date.present?
         to_date=from_date_obj.to_date
       end
      end
    employee.mg_employee_payslips.build(:payscale=>payscale, :is_deleted=>0, :from_date=>to_date, :to_date=>Date.today, :mg_school_id=>mg_school_id, :updated_by=>updated_by)
    end
  end




  def verify_employee_record
    begin

        puts"varifyEmpRecord ajax"
        puts params[:empId]
        @timeformat = MgSchool.find(session[:current_user_school_id])
        @dateOfBirth = Date.strptime(params[:empDOB],@timeformat.date_format)
        empId=params[:empId]
        empFirstName=params[:empFirstName]
        empLastName=params[:empLastName]
        empFatherName=params[:empFatherName]


        account_details=false



        if params[:varifyEmpRecord]=="employee_edit"
          sql=" SELECT mg_employees.* FROM mg_employees where id !="+empId+" AND 
           first_name='"+empFirstName+"' AND
           last_name='"+empLastName+"' AND
           father_name='"+empFatherName+"' AND
           date_of_birth='"+@dateOfBirth.to_s+"'"
           puts "employee_edit--."
           account_details=MgBankAccountDetail.where(:is_deleted=>0, :mg_school_id=>session[:current_user_school_id], :account_number=>params[:account_number], :ifs_code=>params[:ifs_code]).where("mg_employee_id != ?", empId).present?

        elsif params[:varifyEmpRecord]=="employee_new"
          sql=" SELECT mg_employees.* FROM mg_employees where 
           first_name='"+empFirstName+"' AND
           last_name='"+empLastName+"' AND
           father_name='"+empFatherName+"' AND
           date_of_birth='"+@dateOfBirth.to_s+"'"
           puts "employee_new--."

           account_details=MgBankAccountDetail.where(:is_deleted=>0, :mg_school_id=>session[:current_user_school_id], :account_number=>params[:account_number], :ifs_code=>params[:ifs_code]).present?

       end
        @employeeObj=MgEmployee.find_by_sql(sql)
        puts @employeeObj.inspect
        render :json => {:empObj => @employeeObj,:rescue_empObj =>0 , :account_details=> account_details}
        rescue Exception => ex 
        @object="Error occured, please contact administrator" 
        render :json => {:rescue_empObj => @object,:empObj => 0, :account_details=> account_details} 

      end 
    end

    def employee_records_delete
      @delete=MgDocumentManagement.find(params[:documentID])
      @delete.delete
    end

    
    def show
          @employee = MgEmployee.find(params[:id])
          @employeeUserId= @employee.mg_user_id

          @address=MgAddress.where(mg_user_id: @employeeUserId)

          @contact=MgPhone.where(mg_user_id: @employeeUserId)
          @email=MgEmail.where(mg_user_id: @employeeUserId)


         @dbdatas = MgCommonCustomField.where(model_name: "employee",is_deleted:0,mg_school_id:session[:current_user_school_id])

         @customData = MgCustomFieldsData.where(mg_user_id:@employee.mg_user_id,is_deleted:0,mg_school_id:session[:current_user_school_id])
          @languageList = MgLanguage.where(mg_user_id:@employee.mg_user_id,is_deleted:0,mg_school_id:session[:current_user_school_id])
          add_breadcrumb "Show"

         @account_details=MgBankAccountDetail.find_by(:mg_employee_id=>params[:id])
          if session[:user_type]!="front_office_manager"
            render :layout => false
          end

    end

    def edit

      @employee = MgEmployee.find(params[:id])

     

      @dbdatas = MgCommonCustomField.where(model_name: "employee",is_deleted:0,mg_school_id:session[:current_user_school_id])
      @customData = MgCustomFieldsData.where(mg_user_id:@employee.mg_user_id,is_deleted:0,mg_school_id:session[:current_user_school_id])


      @Permanent=MgAddress.find_by(:mg_user_id=>@employee.mg_user_id, :address_type => 'Permanent')
      @Temporary=MgAddress.find_by(:mg_user_id=>@employee.mg_user_id, :address_type => 'Temporary')

      @phone=MgPhone.find_by(:mg_user_id=>@employee.mg_user_id, :phone_type => 'phone')
      @mobile=MgPhone.find_by(:mg_user_id=>@employee.mg_user_id, :phone_type => 'mobile')
    
      @email=MgEmail.find_by(:mg_user_id=> @employee.mg_user_id)

      @languageList = MgLanguage.where(mg_user_id:@employee.mg_user_id,is_deleted:0,mg_school_id:session[:current_user_school_id])

      @account_details=MgBankAccountDetail.find_by(:mg_employee_id=>params[:id])
      puts "edit test"
      puts @account_details.inspect
      puts "edit test"

        render :layout => false
    end

def update
mg_school_id=session[:current_user_school_id]
      updated_by=session[:user_id]

    # User ADD
    # employee
    begin
    MgEmployee.transaction do
       @employee = MgEmployee.find(params[:id])
       #payslip work start
         # create_employee_payslip(params[:employee][:pay_scale],@employee, mg_school_id,updated_by,updated_by, "update")
         # create_employee_payslip(payscale,@employee, mg_school_id,created_by,created_by, type)
      
         @account_details=MgBankAccountDetail.find_by(:mg_employee_id=>params[:id])
         if @account_details.present?
          @account_details.update(account_details_params)
        else
          @employee.mg_bank_account_details.build(account_details_params)
        end

         update_employee_grade_component(@employee,mg_school_id,updated_by,updated_by,params[:employee][:mg_employee_grade_id],params[:previous_employee_grade_id] )

       #payslip work end
      
       @employeeId= @employee.mg_user_id
        


      # language work startEd
      @oldLanguageList = MgLanguage.destroy_all(mg_user_id:  @employeeId)

      
      langArr = params[:language][:language_name]
      readArr =  params[:language][:read]
      writeArr =  params[:language][:write]
      speakArr =  params[:language][:speak]


      puts langArr.inspect
      puts readArr.inspect
      puts writeArr.inspect
      puts speakArr.inspect



      unless langArr.nil? || langArr == 0

        langArr.each do |langName|
          puts " ---------------------Step -- 1 -------------------     "
          if langName.length > 0
            # iterate read Array and create new object lang-name is langName

            @language = MgLanguage.new
            @language.language_name = langName
            @language.mg_user_id = @employeeId
            @language.is_deleted = 0
            @language.mg_school_id = session[:current_user_school_id]
              @language.save

        
            unless readArr.nil? || readArr == 0

              readArr.each do |readLang|

                if readLang.include? langName
                  puts "------------------Read Lang -------------------------------------"
                  readSplt =  readLang.split("$")
                  readStandard = readSplt[1]
                  @language.update(:read=>readStandard.to_s)
                  puts "------------------Read Lang -------------------------------------" +readStandard
              end
              end
              
            end

            unless writeArr.nil? || writeArr == 0

              writeArr.each do |writeLang|

                if writeLang.include? langName
                  puts "------------------write Lang -------------------------------------"
                  writeSplt =  writeLang.split("$")
                  writeStandard = writeSplt[1]

                  @language.update(:write=>writeStandard.to_s)
                  puts "------------------write Lang -------------------------------------" +writeStandard
              end
              end
            end


          unless speakArr.nil? || speakArr == 0
            # ...
              speakArr.each do |speakLang|

                if speakLang.include? langName
                  puts "------------------speak Lang -------------------------------------"
                  speakSplt =  speakLang.split("$")
                  speakStandard = speakSplt[1]
                  @language.update(:speak=>speakStandard.to_s)
                  puts "------------------speak Lang -------------------------------------" +speakStandard
              end
              end
          end

          end
        end
      end



      # language work end



       # update address
       
       @temporary_address=MgAddress.find_by_mg_user_id_and_address_type(@employeeId, "Temporary")

     

require 'open-uri'



        
            
            @file=params[:file]
           # @fileupload.file=params[:file]
            if @file.nil?
            else
           @file.each do |a|
           @fileupload=MgDocumentManagement.new()
            
           @fileupload.file=a
           
           @fileupload.document_type="SportsActivity"
           @fileupload.mg_user_id=@employee.mg_user_id
        
           @fileupload.save
          
          end
          
          end
          
          @files=params[:files]
          puts params[:files].inspect
           # @fileupload.file=params[:file]
           puts "hello"
           puts params[:files].inspect
           if @files.nil?
           else
           @files.each do |a|
           @fileupload=MgDocumentManagement.new()
            
           @fileupload.file=a
         
            @fileupload.document_type="ExtraCurricular"
           @fileupload.mg_user_id=@employee.mg_user_id
        
           @fileupload.save
          
          end
          
          end
            


      # @temporary_address.update(temporary_address_params)

       @permanent_address=MgAddress.find_by_mg_user_id_and_address_type(@employeeId, "Permanent")
       # @permanent_address.update(temporary_address_params)


      # Phone Number Work

      @emergency_number=MgPhone.find_by_mg_user_id_and_phone_type(@employeeId, "phone")
     
      @personal_number=MgPhone.find_by_mg_user_id_and_phone_type(@employeeId, "mobile")
      
      #E-mail Work

      @email_address=MgEmail.find_by_mg_user_id_and_email_type(@employeeId, "home")
      
     
#       
      @custFieldNameIds = params[:custom_data]
            if  @custFieldNameIds.nil?
              else
                for j in 0...@custFieldNameIds.size
                  @custFieldValObj = params[:"custom_field_#{@custFieldNameIds[j]}"]
                  if !@custFieldValObj.nil? && @custFieldValObj.size>0
                     @custFieldVal =@custFieldValObj[0];
                      for index in 1...@custFieldValObj.size 
                      @custFieldVal << ','+@custFieldValObj[index]
                      end 
                  end 
                  @id=@custFieldNameIds[j]

                  @userName =  params[:employee][:employee_number ]

                  @userObj = MgUser.where(:user_name=>@userName)

                  puts "Hello"
                  # puts @userObj[0][:id]
                  @userObjId = @userObj[0].id
                  logger.info("I am in if condition==================")
                  logger.info(@userObjId)
                  logger.info(@id)
                   @details = MgCustomFieldsData.where(:mg_custom_field_id=>@id,:mg_user_id=>@userObjId)
                   logger.info(@details.inspect)
                      if @details.size<1
                        logger.info("I am in if condition")
                        @savedetails=MgCustomFieldsData.new(save_params) 
                        @savedetails.value=@custFieldVal
                        @savedetails.mg_custom_field_id=@id
                        @savedetails.mg_user_id = @userObjId
                        @savedetails.save
                      else
                        logger.info("I am in else condition")
                        @data = @custFieldVal
                        @details[0].update(value: @data)
                      end
                end
              end    
        
        puts "Out side If loop in update "
       if  @employee.update(employees_params)
        if params[:employee_hod_specialization].present?
          @employee.update(:hod_specialization_id=>params[:employee_hod_specialization])
        end
        # ===================Specialization Changes===================================
        if params[:selectedEmployeeSpecialization].present?
            @params=params[:selectedEmployeeSpecialization]
            employee_particular_specialization=MgParticularSpecialization.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_employee_id=>@employee.id)
            employee_particular_specialization.each do |emp_spec|
              emp_spec.update(:is_deleted=>1)
            end
      for j in 0...@params.size
        employee_particular_specialization_count=MgParticularSpecialization.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_employee_id=>@employee.id,:mg_employee_specialization_id=>@params[j]).count
                if employee_particular_specialization_count<1
                        @specialization=MgParticularSpecialization.new()
                        @specialization.mg_employee_id=@employee.id
                        @specialization.mg_employee_specialization_id=@params[j]
                        @specialization.is_deleted=0
                        @specialization.mg_school_id=session[:current_user_school_id]
                      # @specialization.created_by=session[:user_id]
                        @specialization.updated_by=session[:user_id]
                        @specialization.save
                        end
                end
          end
        # ===============================================================================
        @employee.update(:mg_employee_grade_id=>params[:employee][:mg_employee_grade_id])
        puts "in side If loop in update "
          @temporary_address.update(temporary_address_params)
          @permanent_address.update(permanent_address_params)
          #@emergency_number.update(emergency_phone_params)
          @personal_number.update(personal_phone_params)
          @email_address.update(email_params)
          @timeformat = MgSchool.find(session[:current_user_school_id])
    
          @joiningDate = Date.strptime(params[:employee][:joining_date],@timeformat.date_format)
          @dateOfBirth = Date.strptime(params[:employee][:date_of_birth],@timeformat.date_format)
          if params[:employee][:last_working_day].present?
          last_working_day = Date.strptime(params[:employee][:last_working_day],@timeformat.date_format)

          @employee.update(:joining_date => @joiningDate,:date_of_birth => @dateOfBirth,:last_working_day => last_working_day)
        else
          @employee.update(:joining_date => @joiningDate,:date_of_birth => @dateOfBirth)

        end
          #update first name and last name in user table
          @employee.mg_user.update(:first_name => params[:employee][:first_name], 
                                   :last_name => params[:employee][:last_name])
          #end here

          #update school id in mg user
          if params[:employee][:is_employee]=="superprincipal" || params[:employee][:is_employee]=="admin" || params[:employee][:is_employee]=="principal"
            @employee.mg_user.update(:mg_school_id => params[:employee][:mg_school_id])
          end
          #end here

          if params[:employee][:is_employee]=="superprincipal"
              redirect_to :controller=>'cloud_admins', :action=>'show_super_principal'
          elsif params[:employee][:is_employee]=="admin"
              redirect_to :controller=>'cloud_admins', :action=>'admin_index'
          elsif params[:employee][:is_employee]=="principal"
              redirect_to :controller=>'cloud_admins', :action=>'principal_index'
          else
              redirect_to :back
           end
         #redirect_to '/employees'
      end
    end #for transaction
    rescue
    flash[:error]="Error occured, please contact administrator"
  redirect_to :back
  end
   
end

def update_employee_grade_component(mg_employee_id,mg_school_id,created_by,updated_by,mg_employee_grade_id, previous_id)
    

    puts "mg_employee_grade_id=====>#{mg_employee_grade_id}"
    puts "previous_id=====>#{previous_id}"

  if mg_employee_grade_id.to_i==previous_id.to_i
    puts "not changed----------------------------"
  else
    puts "changed----------------------------"
    mg_employee_grade_component=MgEmployeeGradeComponent.where(:is_deleted=>0, :mg_employee_id=>mg_employee_id.id, :mg_school_id=>mg_school_id)
    mg_employee_grade_component.update_all(:is_deleted=>1)


    grade_component=MgGradeComponent.where(:is_deleted=>0, :mg_school_id=>mg_school_id, :mg_employee_grade_id=>mg_employee_grade_id, :is_applicable=>1)
      grade_component.each do |component| 
        mg_employee_id.mg_employee_grade_components.build(:is_deleted=>0, :mg_school_id=>mg_school_id, :mg_salary_component_id=>component.mg_salary_component_id, :amount=>component.amount, :created_by=>created_by,:updated_by=>created_by, :is_edited=>0)
      end


  end
   
end

    def delete
      created_by=session[:user_id]
      @employee = MgEmployee.find(params[:id])
      @employee.update(:is_deleted => 1)
      @employee_user_id = MgEmployee.where(:id=>params[:id]).pluck(:mg_user_id)
      @employee_user=MgUser.where(:id=>@employee_user_id[0])
      @employee_user[0].update(:is_deleted => 1)

      create_employee_payslip("000000",@employee, @employee.mg_school_id,created_by,created_by, "delete")
      redirect_to '/employees'
    end


    #==========below part updated on 15th jan=================================
   def pdf_gen
@@temp=1
    @employeedatas=MgEmployee.find(params[:id])
     school=MgSchool.find(session[:current_user_school_id])
    @@school_logo=school.logo.url(:medium, timestamp: false)
    @@emp_photo=@employeedatas.photo.url
    puts "tttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt"
    puts @@emp_photo
    puts "tttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt"
      @last_employee = @employeedatas.id
      puts "before mg_user_id"
      @employeeUserId= @employeedatas.mg_user_id
      #@customData = MgCustomFieldsData.where(mg_user_id:@employeeUserId,is_deleted:0,mg_school_id:session[:current_user_school_id])
#customfield========================================================================
           
  

  @@dbdatas = MgCommonCustomField.where(model_name: "employee",is_deleted:0,mg_school_id:session[:current_user_school_id])

  @@customData = MgCustomFieldsData.where(mg_user_id:@employeeUserId,is_deleted:0,mg_school_id:session[:current_user_school_id])
 
#customfield========================================================================
        
       @employee_details="select employee_number, DATE_FORMAT(joining_date,'%d/%m/%Y') 'joining date', first_name,middle_name, last_name, gender,DATE_FORMAT(date_of_birth,'%d/%m/%Y') 'date of birth',language,blood_group,mg_employee_category_id,mg_employee_type_id,mg_employee_position_id,mg_employee_department_id,job_title,qualification,experience_year, experience_month,is_dean from mg_employees where id=#{@employeedatas.id}"
       @employee_details=MgEmployee.find_by_sql(@employee_details)
       std_all_dada=@employee_details.as_json 

       #Specialization 

       @employee_details_hod="select is_hod, hod_specialization_id from mg_employees where id=#{@employeedatas.id}"
       @employee_details_hod=MgEmployee.find_by_sql(@employee_details_hod)
       std_all_dada_hod=@employee_details_hod.as_json

       @@empId=@employeedatas.id
       @@school_id=session[:current_user_school_id]

       puts "---------------------------------------------------"
       @employee_spec_hod="select mg_employee_specialization_id from mg_particular_specializations where mg_employee_id=#{@employeedatas.id}"
       @employee_spec_hod=MgParticularSpecialization.find_by_sql(@employee_spec_hod)
       std_all_dada_spec=@employee_spec_hod.as_json

       puts "====================================================================="

       puts std_all_dada_spec.inspect

       puts "====================================================================="





       #Personal Details
       @personal_query="select marital_status,mother_name,father_name,nationality from mg_employees where id=#{@employeedatas.id}"
       personal_detail=MgEmployee.find_by_sql(@personal_query)
       employee_personal_detail=personal_detail.as_json

       #Language Known
       #language_known="select language_name,read,write,speak from mg_languages where mg_user_id=#{@employeeUserId}"
      languageLists = MgLanguage.where(:mg_user_id=>@employeeUserId,is_deleted:0,mg_school_id:session[:current_user_school_id])
      



      #language_details=languageList.as_json

      @get_emp_paddress="select  address_line1, address_line2, city, state , pin_code, landmark,country,street from mg_addresses where mg_user_id=#{@employeeUserId} AND address_type='Permanent'"
      @emp_p=MgAddress.find_by_sql(@get_emp_paddress)
      std_p=@emp_p.as_json 
      
      #c address
      @get_emp_caddress="select  address_line1, address_line2, city, state , pin_code, landmark,country,street from mg_addresses where mg_user_id=#{@employeeUserId} and address_type='Temporary'"
      @emp_ca=MgAddress.find_by_sql(@get_emp_caddress)
      std_c=@emp_ca.as_json 

      #STUDENT HOME PHONE NUMBER
      @emp_h_phone="SELECT phone_number,notification,subscription from mg_phones where mg_user_id=#{@employeeUserId} and phone_type='mobile'"
      @emp_h_phone=MgPhone.find_by_sql(@emp_h_phone)
      std_h_phone=@emp_h_phone.as_json
      # logger.info "inside phone"
      # logger.info std_h_phone

      #STUDENT HOME PHONE NUMBER
      @emp_p_phone="SELECT phone_number from mg_phones where mg_user_id=#{@employeeUserId} and phone_type='phone'"
      @emp_p_phone=MgPhone.find_by_sql(@emp_p_phone)
      std_p_phone=@emp_p_phone.as_json
      puts"phone==============================================================================="
      # logger.info "inside phone"
      # logger.info std_p_phone \\@email=MgEmail.where(mg_user_id: @studentUserId)
      @emp_email="SELECT mg_email_id,notification,subscription from mg_emails where mg_user_id=#{@employeeUserId}"
      @emp_email=MgEmail.find_by_sql(@emp_email)
      employee_email=@emp_email.as_json

      #emergency Contact detail
      @employee_emergency_query="select emergency_contact_name,emergency_contact_number from mg_employees where id=#{@employeedatas.id}"
      @employee_emergency_contact_detail=MgEmployee.find_by_sql(@employee_emergency_query)
      employee_emergency_as_json=@employee_emergency_contact_detail.as_json
      puts "emergency Contact detail=="
      puts employee_emergency_as_json



      @@employeedatas=@employeedatas.id
      @@some=@employeedatas.mg_user_id
      @@stu="0"+@@employeedatas.to_s
      @@stuphoto=@@some.to_s+".jpeg"
      account_details=MgBankAccountDetail.find_by(:mg_employee_id=>params[:id], :is_deleted=>0)
      pdf = Prawn::Document.new do  
                      

                  repeat :all do
 # header
                        bounding_box [bounds.left, bounds.top],:align => :right, :width  => bounds.width do
                          font "Helvetica"
                          if File.exists?("#{Rails.root}/public/#{@@school_logo}") 
                             image( "#{Rails.root}/public/#{@@school_logo}",:width =>  45)
                            # image ("#{Rails.root}/public/#{@@school_logo}"),:at=>[425,690],:width=>45
                            # image "#{Rails.root}/public/#{@@school_logo}", :width => 45, :align => :left
                          
                           end
                           move_up 15
                          text school.school_name, :align => :center, :size => 18
                          stroke_horizontal_rule
                         end
        move_down 10

        # footer
                        bounding_box [bounds.left, bounds.bottom + 45], :width  => bounds.width do
                            font "Helvetica"
                            stroke_horizontal_rule
                            move_down(5)
                            # text " Powered By - ©", :size => 12
                            move_down 12
                            draw_text "Terms & Conditions| Privacy Policy| About Us| Contact Us",:at => [70,3]
                            draw_text "Powered By - ©", :at => [400,3]
                            image "#{Rails.root}/app/assets/images/mindcom-logo.png", :at=>[495,15], :width => 45, :align => :right
                        end
                  end
               

 bounding_box([bounds.left, bounds.top - 60], :width  => bounds.width, :height => bounds.height - 100) do

                      # string = "page <page> of <total>"
                      # # Green page numbers 1 to 11
                      # options = { :at => [bounds.right - 150, 0],
                      #  :width => 150,
                      #  :align => :right,
                      #  :page_filter => (1..11),
                      #  :start_count_at => 1,
                      #  :color => "018fda" }
                      # number_pages string, options

                    move_down 100
                    puts "before general llllllllllllllll"

                    if  File.exists?("#{Rails.root}/public/#{@@emp_photo}")
                        image( "#{Rails.root}/public/#{@@emp_photo}",:at => [450,600], :width =>  65)
                    else
                    end
                    
      text "General "
                    data =  Array.new
                    widths = Array.new(30, 50)
                    cell_height = 15
                    count=0
                    
                    $rowdata=Array.new
                    
                    std_all_dada[0].each_with_index { |(key, value), index|
                    if index % 2==0
                      $rowdata=Array.new
                    end
                   
                    if(key != 'id')
                      if( key =='date of birth')
                        str="Date of Birth"
                      elsif key=="language"
                        str="Mother Tongue"
                      elsif key=="mg_employee_category_id"
                        str="Employee Category"
                        employee_category=MgEmployeeCategory.find(value)
                        value=employee_category.category_name
                      elsif key=="mg_employee_type_id"
                        str="Employee Type"
                        employee_type=MgEmployeeType.find(value)
                        value=employee_type.employee_type
                      elsif key=="mg_employee_position_id"
                        str="Employee Profile"
                        employee_position=MgEmployeePosition.find(value)
                        value=employee_position.position_name
                      elsif key=="mg_employee_department_id"
                        str="Employee Department"
                        employee_department=MgEmployeeDepartment.find(value)
                        value=employee_department.department_name
                      elsif key=="is_dean"
                        str="Is Dean"
                            if value==true
                                value="Yes"
                              else
                                value="No"
                              end
                      else
                          str=key.tr('_', ' ') 
                          str=str.titleize
                      end     
                    inner_table = make_table([ ["#{str}","#{value}"] ],:column_widths => 135)
                              
                                # display +=["#{value}"]
                                end
                    $rowdata +=[inner_table]
                    if index % 2==1
                    table([$rowdata],:column_widths => 270)  
                     
                    end 

                    }

                    move_down 25



# ==================================================================================================


text "Specialization "
                    data =  Array.new
                    widths = Array.new(30, 50)
                    cell_height = 15
                    count=0
                    
                    $rowdata=Array.new
                    
                    std_all_dada_hod[0].each_with_index { |(key, value), index|
                    if index % 2==0
                      $rowdata=Array.new
                    end
                   
                    if(key != 'id')
                      if key=="is_hod"
                        str="Is hod"
                            if value==true
                                value="Yes"
                              else
                                value="No"
                              end
                      elsif key=="hod_specialization_id"
                        str="HOD Specialization"
                        empSpecialization=MgEmployeeSpecialization.find_by(:id=>value)
                        if empSpecialization.present?
                          value=empSpecialization.try(:name)
                        else
                          value='  ---   '
                        end
                      else
                          str=key.tr('_', ' ') 
                          str=str.titleize
                      end     
                    inner_table = make_table([ ["#{str}","#{value}"] ],:column_widths => 135)
                              
                                # display +=["#{value}"]
                                end
                    $rowdata +=[inner_table]
                    if index % 2==1
                    table([$rowdata],:column_widths => 270)  
                     
                    end 

                    }

                   # move_down 25

# ======================================================================
                    

                    if std_all_dada_spec[0].present?


                    str2=""
                    data =  Array.new
                    widths = Array.new(30, 50)
                    cell_height = 15
                    count=0
                    
                    $rowdata=Array.new
                    




                    std_all_dada_spec[0].each_with_index { |(key, value), index|
                    if index % 2==0
                      $rowdata=Array.new
                    end
                   
                    if(key != 'id')
                      if key=="mg_employee_specialization_id"
                        str="Specialization"
                            empSpecialization=MgEmployeeSpecialization.find_by(:id=>value)
                        if empSpecialization.present?
                          value=empSpecialization.try(:name)
                        end
                      else
                          str=key.tr('_', ' ') 
                          str=str.titleize
                      end     
                 

                      temp1=MgParticularSpecialization.where(:mg_employee_id=>@@empId,:is_deleted=>0,:mg_school_id=>@@school_id).pluck(:mg_employee_specialization_id).uniq
                      temp1.each do |i|
                        empSpec=MgEmployeeSpecialization.find_by(:id=>i)
                        str2=str2+empSpec.try(:name)
                        str2=str2+" "
                      end


                    inner_table = make_table([ ["#{str}","#{str2}"] ],:column_widths => 135)
                              
                                # display +=["#{value}"]
                                end
                    $rowdata +=[inner_table]
                    if index % 2==1
                    table([$rowdata],:column_widths => 270)  
                     
                    end 

                    }

                    move_down 25

                  else
                      move_down 25
                  end









                    if account_details.present?
            text "Account Details"
                    data =  Array.new
                    widths = Array.new(30, 50)
                    cell_height = 15
                    table([["Bank Name",account_details.try(:bank_name), "Branch Name", account_details.try(:branch_address)], ["Account Number", account_details.try(:account_number), "IFS Code", account_details.try(:ifs_code)] ],:column_widths => 270/2)  
                   
                    move_down 25
            end

     
            text "Personal Detail"
                    data =  Array.new
                    widths = Array.new(30, 50)
                    cell_height = 15
                    count=0
                    
                    $rowdata=Array.new
      
                     employee_personal_detail[0].each_with_index { |(key, value), index|
                    if index % 2==0
                      $rowdata=Array.new
                    end
                    
                    str=key.tr('_', ' ') 
                    str=str.titleize
                    inner_table = make_table([ ["#{str}","#{value}"] ],:column_widths => 135)
                              
                                # display +=["#{value}"]
                               
                    $rowdata +=[inner_table]
                    if index % 2==1
                    table([$rowdata],:column_widths => 270)  
                     
                    end 
                    }
                    move_down 25
                    if languageLists.present?
            text "Language Known"
                    data =  Array.new
                    widths = Array.new(50, 50)
                    cell_height = 15
                    count=0
                    
                    
                    columndata=Array.new
                    columndata.push("Language")
                    
                    columndata.push("Read")
                    columndata.push("Write")
                    columndata.push("Speak")
                 table([columndata],:column_widths => 80, :cell_style => { size: font_size })

                    languageLists.each do |eg|
                      rowdata=Array.new
                      rowdata.push (eg.language_name)
                      rowdata.push (eg.read)
                      rowdata.push (eg.write)
                      rowdata.push (eg.speak)

                      
                  #table([languageLists],:column_widths => widths, :cell_style => { size: font_size })
                  table([rowdata],:column_widths => 80, :cell_style => { size: font_size })

                end
              end
                    #  language_details[0].each_with_index { |(key, value), index|
                    # if index % 2==0
                    #   $rowdata=Array.new
                    # end
                    
                    # str=key.tr('_', ' ') 
                    # str=str.titleize
                    # inner_table = make_table([ ["#{str}","#{value}"] ],:column_widths => 135)
                              
                    #             # display +=["#{value}"]
                               
                    # $rowdata +=[inner_table]
                    # if index % 2==1
                    # table([$rowdata],:column_widths => 270)  
                     
                    # end 
                    # }
                     move_down 25



      text "Permanent Address"
                    data =  Array.new
                    widths = Array.new(30, 50)
                    cell_height = 15
                    count=0
                    
                    $rowdata=Array.new
      
                    std_p[0].each_with_index { |(key, value), index|
                    if index % 2==0
                      $rowdata=Array.new
                    end
                    # display=Array.new
                                # display +=["#{key}",":","#{value}"]
                                str=key.tr('_', ' ') 
                    str=str.titleize
                    inner_table = make_table([ ["#{str}","#{value}"] ],:column_widths => 135)
                              
                                # display +=["#{value}"]
                               
                    $rowdata +=[inner_table]
                    if index % 2==1
                    table([$rowdata],:column_widths => 270)  
                     
                    end 
                    }
                    move_down 25

      text "Correspondence Address"
                    data =  Array.new
                    widths = Array.new(30, 50)
                    cell_height = 15
                    count=0
                    
                    $rowdata=Array.new
      
                    std_c[0].each_with_index { |(key, value), index|
                    if index % 2==0
                      $rowdata=Array.new
                    end
                    # display=Array.new
                                # display +=["#{key}",":","#{value}"]
                                str=key.tr('_', ' ') 
                    str=str.titleize
                    inner_table = make_table([ ["#{str}","#{value}"] ],:column_widths => 135)
                              
                                # display +=["#{value}"]
                               
                    $rowdata +=[inner_table]
                    if index % 2==1
                    table([$rowdata],:column_widths => 270)  
                     
                    end 
                    }
                    move_down 25

          
      text "Contact Details "
                    data =  Array.new
                    widths = Array.new(30, 50)
                    cell_height = 15
                    count=0
                    
                    $rowdata=Array.new
                    
                    if std_h_phone[0].present?

                      std_h_phone[0].each_with_index { |(key, value), index|
                            if(key=='phone_number')
                            $phone1 = value
                            end
                          }
                      std_h_phone[0].each_with_index { |(key, value), index|

                           if(key=='notification')
                            $notification = value
                            end
                          }
                          std_h_phone[0].each_with_index { |(key, value), index|

                           if(key=='subscription')
                            $subscription = value
                            end
                          }
                    end

                    if std_p_phone[0].present?

                           std_p_phone[0].each_with_index { |(key, value), index|
                            if(key=='phone_number')
                            $phone2 = value
                            end
                          }
                    end
        #phone No       

                    table([
                        ["Phone Number","#{$phone2}", "Mobile Number","+91-#{$phone1}"]
                        ],:column_widths => 135) 
                    table([
                        ["Notification","#{$notification}", "Subscription","#{$subscription}"]
                        ],:column_widths => 135)

                    employee_email[0].each_with_index { |(key, value), index|
                            if(key=="mg_email_id")
                              $email_id = value
                            end
                          }
                           employee_email[0].each_with_index { |(key, value), index|
                            if(key=="notification")
                             $emailnotification = value
                            end
                          }
                           employee_email[0].each_with_index { |(key, value), index|
                            if(key=='subscription')
                            $emailsubscription = value
                            end
                          }

                    table([
                        ["Email Id","#{$email_id}"]
                        ],:column_widths => 135) 
                    table([
                       ["Notification","#{$emailnotification}", "Subscription","#{$emailsubscription}"]
                        ],:column_widths => 135)


                  
                    move_down 25

          text "Emergency Contact Details "
            data =  Array.new
                    widths = Array.new(30, 50)
                    cell_height = 15
                    count=0
                    
                    $rowdata=Array.new
      
                     employee_emergency_as_json[0].each_with_index { |(key, value), index|
                    if index % 2==0
                      $rowdata=Array.new
                    end
                    if key=="emergency_contact_name"
                      str="Contact Name"
                    else
                      str="Contact Number"
                      value="+91-"+"#{value}"
                      end
                    inner_table = make_table([ ["#{str}","#{value}"] ],:column_widths => 135)

                               
                    $rowdata +=[inner_table]
                    if index % 2==1
                    table([$rowdata],:column_widths => 270)  
                     
                    end 
                    }
                    move_down 25
                   


                if @@customData.size>0
                 text "Custom Fields"
                
                
                 @@dbdatas.each do |dbdata| 
               
             @@customData.each do |custDatas|

            if dbdata.id.to_s==custDatas.mg_custom_field_id


              custom_data=Array.new
            


             


             

               @@customData.each do |custData| 

               if custData.mg_custom_field_id == dbdata.id.to_s
                  @custValue = custData.value
               
               end
             end
              
             
      table([
                      [ dbdata.name ,@custValue]
                        
                        ],:column_widths => 135) 
       
                
        

              
    end

 end               
                end

                      
                    







    

end







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

    
    #==========above part updated on 15th jan=================================

    def custom_new
      @dbdatas = MgCommonCustomField.where(model_name: "employee", is_deleted: 0, :mg_school_id=>session[:current_user_school_id])
      #render :layout => false
    end

    def custom_index
  #render :layout => false

end
    def custom_create

    @customfields = MgCommonCustomField.new(post_params)
      
      @customfields.save
        redirect_to :action=>'custom_new'


      end

  def custom_fields_edit
    @employee_custom_field = MgCommonCustomField.find(params[:id])
      render :layout => false
  end

  def custom_fields_update
    @customfields = MgCommonCustomField.find(params[:id])
   
    @customfields.update(custom_field_params)
    
    redirect_to :action=>'custom_new'
  end
  def custum_fields_delete

      @customfields=MgCommonCustomField.find_by_id(params[:id])
      @customfields.is_deleted =1
      @customfields.save
      redirect_to :action=>'custom_new'
  
    end

    def salary_components
      mg_school_id=session[:current_user_school_id]

      # sort_by_type"=>{"component_type"=>"component"}
      @type="all"
      if params[:sort_by_type].present?
          if params[:sort_by_type] != "components_ok"
            @type=params[:sort_by_type][:component_type]
          else
            @type=params[:component_type]
          end
        if @type !='all'
          @salary_components=MgSalaryComponent.where(:is_deleted=>0, :mg_school_id=>mg_school_id, :is_deduction=>@type).paginate(page: params[:page], per_page: 10)
        else
          @salary_components=MgSalaryComponent.where(:is_deleted=>0, :mg_school_id=>mg_school_id).paginate(page: params[:page], per_page: 10)
        end
      else
      @salary_components=MgSalaryComponent.where(:is_deleted=>0, :mg_school_id=>mg_school_id).paginate(page: params[:page], per_page: 10)
    
      end
    end

    
    def salary_components_new
      @salary_components=MgSalaryComponent.new
      render :layout => false
    end

    def salary_components_create
      updated_by=session[:user_id]
      mg_school_id=session[:current_user_school_id]

      MgSalaryComponent.transaction do
         @salary_components=MgSalaryComponent.new(salary_components_params)
         if @salary_components.save
          #Added By Bindhu For Accounts Starts
          if params[:salary_components][:mg_account_id].present?
            if params[:salary_components][:mg_account_id]=="central"
              @salary_components.update(:is_from_central=>1)
            else
              @salary_components.update(:mg_account_id=>params[:salary_components][:mg_account_id])
            end
          end              
          #Added By Bindhu For Accounts Ends
          @grades=MgEmployeeGrade.where(:is_deleted=>0, :mg_school_id=>mg_school_id)
            @grades.each do |grade_components|
                  @grade_components=@salary_components.mg_grade_components.build(:mg_employee_grade_id=>grade_components.id,:is_deleted=>0, :amount=>0.0, :mg_school_id=>mg_school_id, :created_by=>updated_by, :updated_by=>updated_by)
                  @grade_components.save
            end
          flash[:notice] = "Salary component created successfully"
         else
          flash[:error]="Error occured, please contact administrator"
         end
      end
        redirect_to :back
    end
    def salary_components_edit
       @salary_components=MgSalaryComponent.find(params[:id])
      render :layout => false
      
    end
    def salary_components_update
       @salary_components=MgSalaryComponent.find(params[:id])
        if @salary_components.update(salary_components_params)
          #Added By Bindhu For Accounts Starts
          if params[:salary_components][:mg_account_id].present?
            if params[:salary_components][:mg_account_id]=="central"
              @salary_components.update(:is_from_central=>1)
              @salary_components.update(:mg_account_id=>nil)
            else
              @salary_components.update(:mg_account_id=>params[:salary_components][:mg_account_id])
              @salary_components.update(:is_from_central=>nil)
            end
          end              
          #Added By Bindhu For Accounts Ends

          flash[:notice] = "Salary component updated successfully"
        else
          flash[:error]="Error occured, please contact administrator"
        end
        redirect_to :back
       
      
    end
    def salary_components_delete
      mg_school_id=session[:current_user_school_id]
      @salary_components=MgSalaryComponent.find_by_id(params[:id])


   

    @grade_components= MgGradeComponent.where(:is_deleted=>0, :mg_salary_component_id=>params[:id], :mg_school_id=>mg_school_id,:is_applicable=>1)
    @mg_employee_payslip_components=MgEmployeePayslipComponent.where(:is_deleted=>0, :mg_salary_component_id=>params[:id], :mg_school_id=>mg_school_id)
    @mg_employee_grade_components=MgEmployeeGradeComponent.where(:is_deleted=>0, :mg_salary_component_id=>params[:id], :mg_school_id=>mg_school_id)
   # mg_salary_component_id

   puts @grade_components.inspect
      puts @mg_employee_payslip_components.inspect
      puts @mg_employee_grade_components.inspect


    if @grade_components.present? ||  @mg_employee_payslip_components.present? || @mg_employee_grade_components.present?
      @value ="not_deleted"
    else
      @salary_components.is_deleted =1
      @salary_components.save

      @update=@salary_components.mg_grade_components.update_all(:is_deleted=>1)
      # redirect_to salary_components_path
      @value ="deleted"

    end

        respond_to do |format|
            format.json  { render :json => {'validation'=> @value } }
          end
      
    end

# ================================Employee Specialization==========================

def specialization
    @specialization=MgEmployeeSpecialization.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id]).paginate(page: params[:page], per_page: 10)
  end

  def specialization_new
    render :layout => false
  end

  def specialization_create
    @specialization=MgEmployeeSpecialization.new(params_specialization)
    @specialization.save
    redirect_to :action=>"specialization"
  end

  def specialization_edit
    @specialization=MgEmployeeSpecialization.find(params[:id])
    render :layout => false
  end

  def specialization_update
    @specialization=MgEmployeeSpecialization.find(params[:id])
    @specialization.update(params_specialization_update)
    redirect_to :action=>"specialization"
  end

  def specialization_delete
    @specialization=MgEmployeeSpecialization.find(params[:id])
    @specialization.update(:is_deleted=>1)
    redirect_to :action=>"specialization"
  end

  def hod_specialization_list
    # @sql = "Select id,name from mg_employee_specialization where id = #{params[:id]} and is_deleted = '0' and mg_school_id = #{session[:current_user_school_id]} "
    #   @positionList = MgEmployeePosition.find_by_sql(@sql)
      @specialization=MgEmployeeSpecialization.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:id=>params[:id].split(","))

      respond_to do |format|
        format.json  { render :json => @specialization }
      end
  end






# =========================================NATURE OF DOCUMENTATION====================================

def document
    @document=MgNatureOfDocument.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id]).paginate(page: params[:page], per_page: 10)
  end

  def document_new
    render :layout => false
  end

  def document_create
    @document=MgNatureOfDocument.new(document_params)
    @document.save
    redirect_to :action=>"document"
  end

  def document_edit
    @document=MgNatureOfDocument.find(params[:id])
    render :layout => false
  end


  def document_show
    @document=MgNatureOfDocument.find(params[:id])
    render :layout => false
  end

  def document_update
    @document=MgNatureOfDocument.find(params[:id])
    @document.update(params_document_update)
    redirect_to :action=>"document"
  end

  def document_delete
    @document=MgNatureOfDocument.find(params[:id])
    @document.update(:is_deleted=>1)
    redirect_to :action=>"document"
  end


  # ==================================================================================================



























    private
#comments added
    def employee_user_params
      params.require(:employee).permit(:user_type, :user_name,:first_name,:last_name,:email, :password, :mg_school_id, :is_deleted)
    end

    def employees_params

      #params.require(:employee).permit(:emergency_contact_number, :emergency_contact_name , :language, :mg_employee_category_id, :employee_number, :joining_date, :first_name, :middle_name, :last_name, :gender, :job_title, :mg_employee_position_id, :mg_employee_department_id, :mg_reporting_manager_id, :mg_employee_grade_id, :qualification, :experience_detail, :experience_year, :experience_month, :status, :status_description, :date_of_birth, :marital_status, :children_count, :father_name, :mother_name, :husband_name, :blood_group, :mg_nationality_id, :is_deleted , :mg_school_id, :photo,:mg_employee_type_id)

      params.require(:employee).permit(:last_working_day, :pay_scale,:emergency_contact_number, :emergency_contact_name , :language, :mg_employee_category_id, :employee_number, :joining_date, :first_name, :middle_name, :last_name, :gender, :job_title, :mg_employee_position_id, :mg_employee_department_id, :mg_reporting_manager_id, :mg_employee_grade_id, :qualification, 
        :experience_detail, :experience_year, :experience_month, :status, :status_description,
         :date_of_birth, :marital_status, :children_count, :father_name, :mother_name, 
         :husband_name, :blood_group, :nationality, :mg_nationality_id, :is_deleted ,
         :sport_activity,:extra_curricular,:hobby, :mg_school_id, :photo,:mg_employee_type_id, :is_ltc_applicable,
         :is_referred, :referred_by, :designation, :max_no_of_class, :is_hod,:is_dean)

    #  params.require(:employee).permit(:mg_employee_category_id, :employee_number, :joining_date, :first_name, :middle_name, :last_name, :gender, :job_title, :mg_employee_department_id, :mg_reporting_manager_id, :mg_employee_grade_id, :qualification, :experience_detail, :experience_year, :experience_month, :status, :status_description, :date_of_birth, :marital_status, :children_count, :father_name, :mother_name, :husband_name, :blood_group, :mg_nationality_id, :mg_employee_position_id, :photo_file_name, :photo_content_type, :image_file, :photo_file_size, :mg_user_id, :mg_school_id, :is_deleted)
    end

    def employees_paysclip_params
      params.require(:employee).permit(:pay_scale, :is_deleted,:mg_school_id, :created_by, :updated_by)
    end


 
    def caddress_params
      params.require(:correspondance).permit(:temporaryaddress,:permanentaddress, :emergencycontactnumber, :emailid, :phone)
    end

    def paddress_params
      params.require(:perment).permit(:temporaryaddress,:permanentaddress, :emergencycontactnumber, :emailid, :phone)
     end
     # Sh code

    def temporary_address_params
       params.require(:Temporary).permit( :address_line1,:address_line2,:city,:state,:pin_code,:country ,:landmark, :address_type, :is_deleted, :mg_school_id)
    end

    def permanent_address_params
       params.require(:Permanent).permit( :address_line1,:address_line2,:city,:state,:pin_code,:country ,:landmark, :address_type, :is_deleted, :mg_school_id)
    end

    def emergency_phone_params
      params.require(:phone).permit(:phone_number, :phone_type, :is_deleted, :mg_school_id)
    end

    def personal_phone_params
      params.require(:mobile).permit(:phone_number, :notification, :subscription, :phone_type, :is_deleted, :mg_school_id)
    end

    def email_params
      params.require(:email).permit(:mg_email_id, :notification, :subscription, :email_type, :is_deleted,:mg_school_id)
    end
    def save_params
   #params.require(:save).permit(:School_id,:custom_field_id,:one['value'],:two['value'],:three['value'],:four['value'])
      params.require(:student).permit(:mg_school_id)

     end
     def post_params
        params.require(:demo).permit(:mg_school_id,:model_name,:name,:text_data,:data_type, :is_deleted)
      end

    def save_params
   #params.require(:save).permit(:School_id,:custom_field_id,:one['value'],:two['value'],:three['value'],:four['value'])
      params.require(:employee).permit(:mg_school_id)

    end

    def custom_field_params
        params.require(:employee_custom_field).permit(:mg_school_id,:model_name,:name,:text_data,:data_type, :is_deleted)
    end

def track_param
        params.require(:syllabus).permit(:mg_employee_id,:mg_syllabus_id,:expected_class,:mg_unit_id,:mg_topic_id,:date, :is_deleted, :mg_school_id, :mg_batch_id)
    end

    def account_details_params
        params.require(:account_details).permit(:ac_holder_name, :account_number,:mg_employee_id,:bank_name,:branch_address,:ifs_code, :is_deleted, :mg_school_id, :created_by,:updated_by)
      
    end

    def salary_components_params
        params.require(:salary_components).permit(:is_deduction,:name, :is_deleted, :mg_school_id, :created_by,:updated_by)
      
    end

    def params_specialization
      params.require(:specialization).permit(:name,:description,:is_deleted,:mg_school_id,:created_by,:updated_by)
    end

    def params_specialization_update
      params.require(:specialization).permit(:name,:description,:is_deleted,:mg_school_id,:updated_by)
      
    end

    def document_params
      params.require(:document).permit(:extention,:name,:description,:is_deleted,:mg_school_id,:created_by,:updated_by)
    end

    def params_document_update
      params.require(:document).permit(:extention,:name,:description,:is_deleted,:mg_school_id,:updated_by)
    end

    def syllabus_track_create_param
        params.require(:syllabus).permit(:class_type,:expected_class_for_practical,:mg_curriculum_grade_id,:mg_subject_id,:mg_wing_id,:mg_timetable_id,:mg_employee_id,:mg_syllabus_id,:expected_class,:mg_unit_id,:mg_topic_id,:date, :is_deleted, :mg_school_id, :mg_batch_id,:created_by,:updated_by)
    end

    def track_update_param
        params.require(:syllabus).permit(:class_type,:expected_class_for_practical,:mg_curriculum_grade_id,:mg_wing_id,:mg_timetable_id,:mg_employee_id,:expected_class,:date, :is_deleted, :mg_school_id, :mg_batch_id,:updated_by)
    end

 end 
