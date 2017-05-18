class CloudAdminsController < ApplicationController
  before_filter :login_required
  layout "mindcom"

	def new_school
		@schools=MgSchool.new
    @dbdatas = MgCommonCustomField.where(model_name: "school")
	end
  def help_document_new
    
  end

  def help_document_create
    
    @help_document=MgHelpDocument.new(help_document_params)
    @help_document.save
    redirect_to :action => "help_document_show"
    
  end

  def help_document_edit
  @help_document = MgHelpDocument.find(params[:id])
  end

  def help_document_update
  puts"in subject update method 888888888888885555555555555555555555"
      @help_document = MgHelpDocument.find(params[:id])
     
      if @help_document.update(help_document_params)
        redirect_to :controller => "cloud_admins" , :action => "help_document_show"
      else
        render 'help_document_edit'
      end
end


def help_document_delete
  @help_document = MgHelpDocument.find(params[:id])
      
      if @help_document.update(:is_deleted => 1)
        render 'help_document_show'
        else
      
      end
  
end
def check_help_document
  if request.xhr?
  puts "0000000000000000000000000000"
puts params[:mg_school_id]
@perticular_count=MgHelpDocument.where(:mg_school_id=>params[:mg_school_id],:user_type=>params[:user_type],:is_deleted=>0).count
puts params[:user_type]
puts "0000000000000000000000000000"

  render :json=> {:employee=>@perticular_count}
  end
  
end



# def help_document_src
#   user=MgUser.find(session[:user_id])
#   @help_document=MgHelpDocument.where(:mg_school_id=>session[:current_user_school_id],:user_type=>user.user_type],:is_deleted=>0).last
#   if @help_document.present?
    
#   else
#   end
  
# end




	def school_index
		#@schools=MgSchool.where(:is_deleted=>0)		
    @schools=MgSchool.where(:is_deleted=>0).paginate(page: params[:page], per_page: 5)
	end

	def add_school_data
		school_id = params[:id]
		puts "Schoollll -1 "
		puts school_id
		puts "Schoollll -1 "
		
		#session[:current_user_school_id] = nil
		session[:current_user_school_id] = school_id

		$current_user_school_id = school_id
		
		redirect_to '/students'
	end


	def show_super_principal

		#@employeeDepartment=MgEmployeeDepartment.where(:is_deleted=>0, :mg_school_id=>session[:current_user_school_id])
    #@employees = MgEmployee.where(:is_deleted => '0')#.paginate(page: params[:page], per_page: 10)
      #@employees = MgEmployee.where(:mg_employee_department_id=>'12')
     # @employees = MgEmployee.where(:is_deleted => '0', :mg_school_id=>session[:current_user_school_id]).where("id != ?", 3).paginate(page: params[:page], per_page: 10)
    all_admins=MgUser.where(:is_deleted=>0, :user_type=>"superprincipal").pluck(:id)
    @employees=MgEmployee.where(:is_deleted=>0,:mg_user_id=>all_admins).paginate(page: params[:page], per_page: 10)

	end

	def school_association
  		# MgMultiSchoolAccess
  		@super_principal=MgUser.where(:is_deleted=>0, :user_type=>'superprincipal')
  end

  	def school_principal_association
  		@school=MgSchool.where(:is_deleted=>0)
  		@mg_user_id=params[:id]
  		@user_obj=MgUser.find_by(:id=>@mg_user_id, :is_deleted=>0)
  		@super_principal=MgMultiSchoolAccess.where(:is_deleted=>0, :mg_user_id=>params[:id]).pluck(:mg_school_id)
  	end


  	def school_principal_association_save


  		user_id=params[:attendances][:mg_user_id]
  		selected_school_ids=params[:mg_school_id]
  		default_school_id=params[:attendances][:default_school_id]
      selected_school_ids.push(default_school_id)

  		# puts "selected_school_ids"
  		# puts selected_school_ids
  		#
  		# puts "selected_school_ids"
  		# puts selected_school_ids

  		# code for add new school in MgMultiSchoolAccess
  		
  		if selected_school_ids.present?
  			selected_school_ids.each_with_index do |school_id,i|
  				multi_school_access_obj=MgMultiSchoolAccess.find_by(
  					                    :mg_user_id=>user_id, :mg_school_id=>school_id)
  				if multi_school_access_obj.present?
  					multi_school_access_obj.update( :is_deleted=>0, :updated_by=>session[:user_id] )
  				else
  					new_multi_school_access_obj=MgMultiSchoolAccess.new(:mg_school_id=>school_id, :mg_user_id=>user_id, 
  						:is_deleted=>0, :created_by=>session[:user_id], :updated_by=>session[:user_id])
  					new_multi_school_access_obj.save
  				end
  			end
  		end

  		# code for remove school from MgMultiSchoolAccess

  		temp=false
  		multi_school_access_objs=MgMultiSchoolAccess.where(:mg_user_id=>user_id,:is_deleted=>0)
  		if multi_school_access_objs.present?
  			schoolId=0
  			existingSchoolId=0
  			multi_school_access_objs.each_with_index do |multi_school_obj,i|
  				selected_school_ids.each_with_index do |school_id,i|
  					schoolId=school_id.to_i
  					existingSchoolId=multi_school_obj.mg_school_id.to_i
	  				if schoolId==existingSchoolId
	  					temp=false
	  					break
	  				else
	  					temp=true
	  				end
	  			end
	  			if temp
	  				multi_school_obj.update( :is_deleted=>1, :updated_by=>session[:user_id] )
	  			end
  			end

  		end





  		# multi_school=Array.new
  		# if params[:mg_school_id].present?
	  	# 	for i in 0...params[:mg_school_id].size
	  	# 		multi_school.push(params[:mg_school_id][i].to_i)
	  	# 	end
	  	# end

  		# all_school=MgMultiSchoolAccess.where(:is_deleted=>0, :mg_user_id=>params[:attendances][:mg_user_id]).pluck(:mg_school_id)
  		# value=all_school-multi_school
  		
	  	# if params[:mg_school_id].present?
	  	# 	for i in 0...params[:mg_school_id].size
		  # 		if !MgMultiSchoolAccess.where(:is_deleted=>0, :mg_school_id=>params[:mg_school_id][i],:mg_user_id=>params[:attendances][:mg_user_id]).present?
		  # 			MgMultiSchoolAccess.new(:mg_school_id=>params[:mg_school_id][i], :mg_user_id=>params[:attendances][:mg_user_id], :is_deleted=>0, :created_by=>session[:user_id], :updated_by=>session[:user_id]).save
		  # 		else
		  # 			object=MgMultiSchoolAccess.where(:is_deleted=>0,:mg_school_id=>params[:mg_school_id][i],:mg_user_id=>params[:attendances][:mg_user_id])
		  # 			object[0].save
		  # 		end
	  	# 	end
	  	# end
	  	# if value.present?
	  	# 	for v in 0...value.size
	  	# 		object_absent=MgMultiSchoolAccess.where(:is_deleted=>0,:mg_school_id=>value[v],:mg_user_id=>params[:attendances][:mg_user_id])
	  	# 		object_absent[0].is_deleted=1
	  	# 		object_absent[0].save
	  	# 	end
  		# end
  		redirect_to :controller=>'cloud_admins', :action=>'school_association', :notice=>'School '

  	end



	def super_principal
		  @employee = MgEmployee.new
      find_data = MgEmployee.first
      #for chartkick object
      @languageList = MgLanguage.where(mg_user_id:@employee.mg_user_id)
      @schoolList=MgSchool.where(:is_deleted=>0).pluck(:school_name,:id)
      # @employee = ( flash[:employee] ) ? flash[:employee] : MgEmployee.new
      # @Temporary = (flash[:c_address]) ? flash[:c_address] : MgAddress.new
      # @Permanent = (flash[:p_address]) ? flash[:p_address] : MgAddress.new
      # @phone = (flash[:phone]) ? flash[:phone] : MgPhone.new
      # @mobile = (flash[:personal_phone]) ? flash[:personal_phone] : MgPhone.new
      # @email = (flash[:email]) ? flash[:email] : MgEmail.new
      # #@dbdatas = (flash[:custFields]) ? flash[:custFields] : MgCommonCustomField.where(model_name: "student")
      # flash[:errorInRecords]=(flash[:errorInRecord]) ? flash[:errorInRecord] : ""
      # #flash[:emergency_phone] = @emergency_phone
      @dbdatas = MgCommonCustomField.where(model_name: "employee",is_deleted:0,mg_school_id:session[:current_user_school_id])
      # if MgEmployee.count.zero? # empty array
      #     @strVal='1'
      # else
      #   @lastrecord = MgEmployee.last
      #   @lastadmissionId= @lastrecord.id.to_i
      #   @nextAdmissionNumber = @lastadmissionId + 1;
      #   @strVal = @nextAdmissionNumber.to_s
      # end

	end

  def edit_super_principal

    @employee = MgEmployee.find(params[:id])
    @dbdatas = MgCommonCustomField.where(model_name: "employee")
    @customData = MgCustomFieldsData.where(mg_user_id:@employee.mg_user_id)
    @Permanent=MgAddress.find_by(:mg_user_id=>@employee.mg_user_id, :address_type => 'Permanent')
    @Temporary=MgAddress.find_by(:mg_user_id=>@employee.mg_user_id, :address_type => 'Temporary')
    @phone=MgPhone.find_by(:mg_user_id=>@employee.mg_user_id, :phone_type => 'phone')
    @mobile=MgPhone.find_by(:mg_user_id=>@employee.mg_user_id, :phone_type => 'mobile')
    @email=MgEmail.find_by(:mg_user_id=> @employee.mg_user_id)
    @schoolList=MgSchool.where(:is_deleted=>0).pluck(:school_name,:id)
    @languageList = MgLanguage.where(mg_user_id:@employee.mg_user_id)
    render :layout => false

  end

  
  def show_super_principal_profile

    @employee = MgEmployee.find(params[:id])
    @employeeUserId= @employee.mg_user_id
    @address=MgAddress.where(mg_user_id: @employeeUserId)
    @contact=MgPhone.where(mg_user_id: @employeeUserId)
    @email=MgEmail.where(mg_user_id: @employeeUserId)
    @dbdatas = MgCommonCustomField.where(model_name: "employee")
    @customData = MgCustomFieldsData.where(mg_user_id:@employee.mg_user_id)
    @languageList = MgLanguage.where(mg_user_id:@employee.mg_user_id)
    add_breadcrumb "Show"
    #render :layout => false

  end

  def delete_super_principal

     employee = MgEmployee.find(params[:id])
     employee.update(:is_deleted => 1)
     @employee.mg_user.update(:is_deleted => 1)
     redirect_to '/cloud_admins/show_super_principal'

  end

  def admin_index

    all_admins=MgUser.where(:is_deleted=>0, :user_type=>"admin").pluck(:id)
    @employees=MgEmployee.where(:is_deleted=>0,:mg_user_id=>all_admins).paginate(page: params[:page], per_page: 10)

  end

  def new_admin

    @employee = MgEmployee.new
    find_data = MgEmployee.first
    @languageList = MgLanguage.where(mg_user_id:@employee.mg_user_id)
    @schoolList=MgSchool.where(:is_deleted=>0).pluck(:school_name,:id)
    @dbdatas = MgCommonCustomField.where(model_name: "employee",is_deleted:0,mg_school_id:session[:current_user_school_id])
    # if MgEmployee.count.zero? # empty array
    #     @strVal='1'
    # else
    #   @lastrecord = MgEmployee.last
    #   @lastadmissionId= @lastrecord.id.to_i
    #   @nextAdmissionNumber = @lastadmissionId + 1;
    #   @strVal = @nextAdmissionNumber.to_s
    # end

  end

  def edit_admin

    @employee = MgEmployee.find(params[:id])
    @dbdatas = MgCommonCustomField.where(model_name: "employee")
    @customData = MgCustomFieldsData.where(mg_user_id:@employee.mg_user_id)
    @Permanent=MgAddress.find_by(:mg_user_id=>@employee.mg_user_id, :address_type => 'Permanent')
    @Temporary=MgAddress.find_by(:mg_user_id=>@employee.mg_user_id, :address_type => 'Temporary')
    @phone=MgPhone.find_by(:mg_user_id=>@employee.mg_user_id, :phone_type => 'phone')
    @mobile=MgPhone.find_by(:mg_user_id=>@employee.mg_user_id, :phone_type => 'mobile')
    @email=MgEmail.find_by(:mg_user_id=> @employee.mg_user_id)
    @schoolList=MgSchool.where(:is_deleted=>0).pluck(:school_name,:id)
    @languageList = MgLanguage.where(mg_user_id:@employee.mg_user_id)
    render :layout => false

  end

  def show_admin

    @employee = MgEmployee.find(params[:id])
    @employeeUserId= @employee.mg_user_id
    @address=MgAddress.where(mg_user_id: @employeeUserId)
    @contact=MgPhone.where(mg_user_id: @employeeUserId)
    @email=MgEmail.where(mg_user_id: @employeeUserId)
    @dbdatas = MgCommonCustomField.where(model_name: "employee")
    @customData = MgCustomFieldsData.where(mg_user_id:@employee.mg_user_id)
    @languageList = MgLanguage.where(mg_user_id:@employee.mg_user_id)
    add_breadcrumb "Show"
    
  end

  def delete_admin

     @employee = MgEmployee.find(params[:id])
     @employee.update(:is_deleted => 1)
     @employee.mg_user.update(:is_deleted => 1)
     redirect_to '/cloud_admins/admin_index'

  end

  def principal_index

    all_admins=MgUser.where(:is_deleted=>0, :user_type=>"principal").pluck(:id)
    @employees=MgEmployee.where(:is_deleted=>0,:mg_user_id=>all_admins).paginate(page: params[:page], per_page: 10)

  end

  def add_principal

    @employee = MgEmployee.new
    find_data = MgEmployee.first
    @languageList = MgLanguage.where(mg_user_id:@employee.mg_user_id)
    @schoolList=MgSchool.where(:is_deleted=>0).pluck(:school_name,:id)
    @dbdatas = MgCommonCustomField.where(model_name: "employee",is_deleted:0,mg_school_id:session[:current_user_school_id])
    # if MgEmployee.count.zero? # empty array
    #   @strVal='1'
    # else
    #   @lastrecord = MgEmployee.last
    #   @lastadmissionId= @lastrecord.id.to_i
    #   @nextAdmissionNumber = @lastadmissionId + 1;
    #   @strVal = @nextAdmissionNumber.to_s
    # end

  end

  def edit_principal

    @employee = MgEmployee.find(params[:id])
    @dbdatas = MgCommonCustomField.where(model_name: "employee")
    @customData = MgCustomFieldsData.where(mg_user_id:@employee.mg_user_id)
    @Permanent=MgAddress.find_by(:mg_user_id=>@employee.mg_user_id, :address_type => 'Permanent')
    @Temporary=MgAddress.find_by(:mg_user_id=>@employee.mg_user_id, :address_type => 'Temporary')
    @phone=MgPhone.find_by(:mg_user_id=>@employee.mg_user_id, :phone_type => 'phone')
    @mobile=MgPhone.find_by(:mg_user_id=>@employee.mg_user_id, :phone_type => 'mobile')
    @email=MgEmail.find_by(:mg_user_id=> @employee.mg_user_id)
    @schoolList=MgSchool.where(:is_deleted=>0).pluck(:school_name,:id)
    @languageList = MgLanguage.where(mg_user_id:@employee.mg_user_id)
    render :layout => false

  end

  def show_principal

    @employee = MgEmployee.find(params[:id])
    @employeeUserId= @employee.mg_user_id
    @address=MgAddress.where(mg_user_id: @employeeUserId)
    @contact=MgPhone.where(mg_user_id: @employeeUserId)
    @email=MgEmail.where(mg_user_id: @employeeUserId)
    @dbdatas = MgCommonCustomField.where(model_name: "employee")
    @customData = MgCustomFieldsData.where(mg_user_id:@employee.mg_user_id)
    @languageList = MgLanguage.where(mg_user_id:@employee.mg_user_id)
    add_breadcrumb "Show"

  end

  def delete_principal

     @employee = MgEmployee.find(params[:id])
     @employee.update(:is_deleted => 1)
     @employee.mg_user.update(:is_deleted => 1)
     redirect_to '/cloud_admins/principal_index'

  end



	# def show_image
 #    @school = MgSchool.find(params[:id])
 #    send_data @school.school_logo, :type => 'image/png',:disposition => 'inline'
 #  end
end

private
#comments addedhelp_document
    def help_document_params
      params.require(:help_document).permit(:user_type, :name, :document, :mg_school_id, :is_deleted, :created_by , :updated_by)
    end
