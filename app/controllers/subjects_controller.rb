class SubjectsController < ApplicationController
	#com
    before_filter :login_required
		layout "mindcom"
		def new 
			@subjects=MgSubject.new
			@class=MgCourse.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id]).pluck(:course_name,:id)
			#render :layout => false
		end
	
		def index
		  	@subjects = MgSubject.where(:is_deleted => 0,:mg_school_id=>session[:current_user_school_id]).order('mg_course_id').paginate(page: params[:page], per_page: 10)
		end

		def batch_subject_asso
			@batches = MgBatch.where(:is_deleted => 0,:mg_school_id=>session[:current_user_school_id]).paginate(page: params[:page], per_page: 10)	
		end


		def emp_subject_asso
			# =====================================================================================
			if params[:custom_param].present?
      			temp=params[:custom_param]
      			custom=temp.split("-")
          		if custom[1].present?
                          #@consumption=MgItemConsumption.where(:mg_lab_id=>custom[1],:is_deleted=>0,:mg_school_id=>session[:current_user_school_id]).paginate(page: params[:page], per_page: 10) 
							@employees = MgEmployee.where(:mg_employee_department_id=>custom[1],:is_deleted => 0,:mg_employee_category_id=>1,:mg_school_id=>session[:current_user_school_id]).paginate(page: params[:page], per_page: 10)	

          		else
                          #@consumption=MgItemConsumption.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id]).paginate(page: params[:page], per_page: 10)
							@employees = MgEmployee.where(:is_deleted => 0,:mg_employee_category_id=>1,:mg_school_id=>session[:current_user_school_id]).paginate(page: params[:page], per_page: 10)	

          		end
          		@id=custom[1]
    		else
			# =====================================================================================
				if params[:short_department_wise].present?
		      		if params[:short_department_wise][:mg_employee_department_id].present?
		         		@value=params[:short_department_wise][:mg_employee_department_id]
		      		else
		         		@value=0
		      		end
		    	else
		      		@value=0
		    	end

		    	if  @value!=0
		      		@id=params[:short_department_wise][:mg_employee_department_id]
		    		#@assignment=MgAssignment.where(:mg_batch_id=>params[:short_lab_wise][:mg_batch_id],:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_employee_id=>@emp[0].id).order(:created_at).paginate(page: params[:page], per_page: 10)
					@employees = MgEmployee.where(:mg_employee_department_id=>params[:short_department_wise][:mg_employee_department_id],:is_deleted => 0,:mg_employee_category_id=>1,:mg_school_id=>session[:current_user_school_id]).paginate(page: params[:page], per_page: 10)	
		    
		  		else
		    		#@assignment=MgAssignment.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_employee_id=>@emp[0].id).order(:created_at).paginate(page: params[:page], per_page: 10)
					@employees = MgEmployee.where(:is_deleted => 0,:mg_employee_category_id=>1,:mg_school_id=>session[:current_user_school_id]).paginate(page: params[:page], per_page: 10)	

		    	end
		    end
			#@employees = MgEmployee.where(:is_deleted => 0,:mg_employee_category_id=>1,:mg_school_id=>session[:current_user_school_id]).paginate(page: params[:page], per_page: 10)	
		end


		def select_subject
			puts "Select subject step -- 1"
			@batches = MgBatch.find(params[:id])
	
			@subjects = MgSubject.where(:is_deleted => 0,:mg_school_id=>session[:current_user_school_id],:mg_course_id=>@batches.mg_course_id)
			@selected_subjects= MgBatchSubject.where(:mg_batch_id => "#{@batches.id}")

				# render :layout => false
			

  	  		logger.info(@batches.inspect)
  	  		logger.info(@subjects.inspect)
  	  		puts @selected_subjects.inspect
			#render :layout => false
  	  		
		end

		def create
			MgSubject.transaction do
		  	@subjects=MgSubject.new(subject_params)
		  	@is_save= @subjects.save
			  	if @is_save
			  		batches=MgBatch.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_course_id=>@subjects.mg_course_id)
			  		puts "batches count"
			  		puts batches.inspect
			  		batches.each do |batch|
			  			batch_subject_association=MgBatchSubject.new
			  			batch_subject_association.mg_batch_id=batch.id
			  			batch_subject_association.mg_subject_id=@subjects.id
			  			batch_subject_association.is_deleted=0
			  			batch_subject_association.mg_school_id=session[:current_user_school_id]
						batch_subject_association.save	
						puts "batches saving"		  			
			  		end
			    redirect_to :action => "index"
			    # redirect_to :action => "show", :id => @subjects.id
			  	else
			    render 'new'
			  	end
			  end
		end

		def show
		  	@subjects = MgSubject.find(params[:id])
		  	render :layout => false
		  	
		end

	  	def edit
	 	@subjects = MgSubject.find(params[:id])
	 	render :layout => false

		end

		def update
			#puts sdnhkalfhkjfdh
		# MgSubject.transaction do
		  @subjects = MgSubject.find(params[:id])
		 puts @subjects.inspect
		# puts lll
		 #@subjects.update(:is_deleted=>1)

		  if @subjects.update(subject_params_update)
		  	 if params[:mg_subject][:mg_elective_group_id].nil?
		  	 	@subjects.update(:mg_elective_group_id=>nil)
		  	 end
		    redirect_to :back
		  else
		    render 'edit'
		  end
		 # end
		end

		def delete
			 @subjects=MgSubject.find_by_id(params[:id])

			@subjects.is_deleted =1
			@subjects.save

		  redirect_to subjects_path
		end

		def destroy

    	    @subjects=MgSubject.find_by_id(params[:id])

			@subjects.is_deleted =1
			@subjects.save

		  redirect_to subjects_path
		end

		def batch_subject
			"Puts batch subject is going"
			@batches = MgBatch.where(:is_deleted => 0,:mg_school_id=>session[:current_user_school_id])

			subId = params[:sub_id_list]

			
			batcha_recive_id = params[:batch_id]
			 if(subId !=nil)

			
									logger.info("inspecting reciving object")
									logger.info(batcha_recive_id)


									# for i in 0...subId.size
									# $batch_id=subId[i]
									# end

									@selected_subjects= MgBatchSubject.where(:mg_batch_id => "#{batcha_recive_id}",:mg_school_id=>session[:current_user_school_id],:is_deleted=>0)
									logger.info(@selected_subjects.inspect)

									$subject_ids=Array.new
									for k in 0...subId.size
										$count=1
										for n in 0...subId.size
											if(subId[k]==subId[n])
												$count +=1
											end

										end
										if($count%2==0)
											$subject_ids.push(subId[k])
										end


									end
									$subject_id=$subject_ids.uniq
									# logger.info("#{$subject_id}")
								from_web=Array.new
								for n in 0...$subject_id.size
									from_web.push($subject_id[n].to_i)

								end
								logger.info(from_web.inspect)
								logger.info("-----------")


						       
								#counting the subject when user not selected
						        $slected_sub_count=0
						        @selected_subjects.each {
									$slected_sub_count +=1
								}
								$sub_select=Array.new
								 @selected_subjects.each do |a|
									$sub_select.push(a.mg_subject_id)
								end
								logger.info($sub_select.inspect)
								logger.info($subject_id.inspect)


								if($slected_sub_count !=0)
									for i in 0...from_web.size
										$man=0
											 # @selected_subjects.each do|a|
											for j in 0...$sub_select.size
													if (from_web[i] == $sub_select[j])
														logger.info("in side delete")
														sub=from_web[i]
														#delete
														sql1="DELETE FROM mg_batch_subjects WHERE mg_subject_id=#{sub} and mg_batch_id=#{batcha_recive_id} and mg_school_id=#{session[:current_user_school_id]}"
														# sql1="UPDATE mg_batch_subjects SET is_deleted = 1 WHERE mg_subject_id=#{sub}"

														ActiveRecord::Base.connection.execute(sql1)
													else
														$man +=1
													end#if end
												#save
													if($slected_sub_count==$man)
														logger.info("in side save")

														sub=$subject_id[i]
														sql="INSERT INTO mg_batch_subjects(mg_batch_id, mg_subject_id, is_deleted ,mg_school_id)VALUES (#{batcha_recive_id},#{sub},0,#{session[:current_user_school_id]})"
														ActiveRecord::Base.connection.execute(sql)

													end

											end#@selected_subject loop end
									end#$subject_id end 
								else
									for i in 0...$subject_id.size
									sub=$subject_id[i]
									sql="INSERT INTO mg_batch_subjects(mg_batch_id, mg_subject_id, is_deleted ,mg_school_id)VALUES (#{batcha_recive_id},#{sub},0,#{session[:current_user_school_id]})"
									ActiveRecord::Base.connection.execute(sql)
									end
								end

			

		end
			#render :layout => false
			redirect_to '/subjects/batch_subject_asso'

			# redirect_to :action => "batch_subject_asso"
			
		end

  def emp_subject
  	puts "Shail ------ 1"
      @employees = MgEmployee.all

      subId = params[:sub_id_list]
      some_id = params[:some_id]
      if(subId !=nil)

      

                        # for i in 0...subId.size
                        # $batch_id=subId[i]
                        # end

                        @selected_subjects= MgEmployeeSubject.where(:is_deleted=>0,:mg_employee_id => "#{some_id}", :mg_school_id => session[:current_user_school_id])
                        logger.info(@selected_subjects.inspect)

                        $subject_ids=Array.new
                        for k in 0...subId.size
                          $count=1
                          for n in 0...subId.size
                            if(subId[k]==subId[n])
                              $count +=1
                            end

                          end
                          if($count%2==0)
                            $subject_ids.push(subId[k])
                          end


                        end
                        $subject_id=$subject_ids.uniq
                        # logger.info("#{$subject_id}")
                      from_web=Array.new
                      for m in 0...$subject_id.size
                        from_web.push($subject_id[m].to_i)

                      end
                      logger.info(from_web.inspect)
                      logger.info("-----------")


                         
                      #counting the subject when user not selected
                          $slected_sub_count=0
                          @selected_subjects.each {
                        $slected_sub_count +=1
                      }
                      $sub_select=Array.new
                       @selected_subjects.each do |a|
                        $sub_select.push(a.mg_subject_id)
                      end
                      logger.info($sub_select.inspect)
                      logger.info($subject_id.inspect)


                      if($slected_sub_count !=0)
                        for i in 0...from_web.size
                          $man=0
                             # @selected_subjects.each do|a|
                            for j in 0...$sub_select.size
                                if (from_web[i] == $sub_select[j])
                                  logger.info("in side delete")
                                  del_sub=from_web[i]
                                  #delete
                                  sql1="DELETE FROM mg_employee_subjects WHERE mg_subject_id=#{del_sub} and mg_employee_id=#{some_id}"
                                  # sql1="UPDATE mg_batch_subjects SET is_deleted = 1 WHERE mg_subject_id=#{sub}"

                                  ActiveRecord::Base.connection.execute(sql1)
                                else
                                  $man +=1
                                end#if end
                              #save
                                if($slected_sub_count==$man)
                                  logger.info("in side save")

                                  sub=$subject_id[i]
                                  sql="INSERT INTO mg_employee_subjects(mg_employee_id, mg_subject_id, is_deleted, mg_school_id )VALUES (#{some_id},#{sub},0,#{session[:current_user_school_id]})"
                                  ActiveRecord::Base.connection.execute(sql)

                                end

                            end#@selected_subject loop end
     						

                        end#$subject_id end 
                      else
                        for i in 0...from_web.size
                        sub1=from_web[i]
                        sql="INSERT INTO mg_employee_subjects(mg_employee_id, mg_subject_id, is_deleted, mg_school_id )VALUES (#{some_id},#{sub1},0,#{session[:current_user_school_id]})"
                        ActiveRecord::Base.connection.execute(sql)
                        end
                      end

                        # for i in 0...$subject_id.size
                        # sub=$subject_id[i]
                        # sql="INSERT INTO mg_batch_subjects(mg_batch_id, mg_subject_id, is_deleted )VALUES (#{$batch_id},#{sub},1)"
                        # ActiveRecord::Base.connection.execute(sql)
                        # end
                        # # logger.info(subId.inspect)
     # redirect_to '/subjects/emp_subject_asso'
                        
      end

     redirect_to '/subjects/emp_subject_asso'
      

      # redirect_to :action => "index"
      
    end


def select_subject_emp
      @employees = MgEmployee.find(params[:id])


      emp_id=@employees.id
      @subjects = MgSubject.where(:is_deleted => 0,:mg_school_id=>session[:current_user_school_id])
      
      @selected_subjects= MgEmployeeSubject.where(:mg_employee_id => "#{emp_id}",:is_deleted => 0,:mg_school_id=>session[:current_user_school_id])


      #   # render :layout => false
end


def course_list
      @courselist = MgCourse.where(:is_deleted=>0, :mg_wing_id=>params[:id], :mg_school_id=>session[:current_user_school_id])#.pluck(:id, :first_name)
      respond_to do |format|
      format.json  { render :json => @courselist }
      end
  end




def elective_group_list
      @max_class = MgElectiveGroup.where(:is_deleted=>0, :id=>params[:id], :mg_school_id=>session[:current_user_school_id])
      respond_to do |format|
      format.json  { render :json => @max_class }
      end
  end





def specialization_verification_list
  	@temp_result=1
  	specialization_count=MgParticularSpecialization.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_employee_id=>params[:employeeId]).pluck(:mg_employee_specialization_id)
			  	if (!(specialization_count[0]==""))
			  	currently_added_subject_count=MgSubject.where("is_deleted=? AND mg_school_id=? AND id=? AND mg_employee_specialization_id IN (?)",0,session[:current_user_school_id],params[:sub_id],specialization_count).count
			  	@temp_result=currently_added_subject_count
			  	else
			  	@temp_result=0
			  	end
  	respond_to do |format|
      format.json  { render :json => @temp_result }
      end
  end


  def elective_type
  	elective_type_id=MgElectiveGroup.where(:id=>params[:mg_elective_group_id],:is_deleted=>0,:mg_school_id=>session[:current_user_school_id]).pluck(:mg_elective_type_id)
  	@elective_type=MgElectiveType.where(:id=>elective_type_id).pluck(:name)
  	respond_to do |format|
      format.json  { render :json => @elective_type }
    end
  end

  def rooms_for_specialization
  	@rooms=MgInstituteRoom.where(:mg_employee_specialization_id=>params[:specialization_id],:is_deleted=>0,:mg_room_type=>"practical").pluck(:room_no,:id)
  	render :layout => false
  end

  private
  def subject_params
    params.require(:mg_subject).permit(:mg_employee_specialization_id,:mg_wing_id,:subject_name, :subject_code, :max_weekly_class, :mg_batch_id, :is_deleted,:mg_school_id,:mg_course_id, :is_core, :is_lab, :no_of_classes,:mg_subject_type_id,:mg_elective_group_id,:mg_institute_room_id)
  end


  def subject_params_update
  	params.require(:mg_subject).permit(:mg_employee_specialization_id,:subject_name, :subject_code, :max_weekly_class, :mg_batch_id, :is_deleted,:mg_school_id,:mg_course_id, :is_core, :is_lab, :no_of_classes,:mg_subject_type_id,:mg_elective_group_id,:mg_institute_room_id)
 # params.require(:mg_subject).permit(:mg_employee_specialization_id,:subject_name,:subject_code, ,:is_deleted,:mg_school_id)
  end


end
