class ShowTimetable
	def student_show_time_table(batch_id,mg_school_id, mg_timetable_id, user_type, mg_user_id)

	puts "****************************************************************************************************************"
	puts user_type.inspect
	puts "****************************************************************************************************************"

	   weekday_arr=[]
	   @timetable=Hash.new
	   @big_weekday=nil
	   count_else=" "
	    if mg_timetable_id.present? && mg_school_id.present? && batch_id.present?
		    @timetables=MgTimeTableEntry.where(:mg_batch_id=>batch_id,:is_deleted=>0, :mg_school_id =>mg_school_id, :mg_timetable_id=>mg_timetable_id)
		    mg_wing_id=MgBatch.find_by(:is_deleted=>0, :mg_school_id=>mg_school_id, :id=>batch_id).mg_wing_id_for_batch
		    class_timings=MgClassTiming.where(:is_deleted=>0, :mg_school_id=>mg_school_id, :mg_wing_id=>mg_wing_id, :is_break=>0).includes(:mg_weekday).order("mg_weekdays.weekday asc")
		    weekday_arr=class_timings.pluck(:mg_weekday_id)
		    puts "weekday_arr--->1<---#{weekday_arr.inspect}"
		    weekday_arr=weekday_arr.uniq
		    puts "weekday_arr--->2<---#{weekday_arr.inspect}"
		    
		    @count_hash=Hash.new
		    for i in 0...weekday_arr.size
		      count=0
		      class_timings.where(:mg_weekday_id=>weekday_arr[i]).each do |t_loop|
		        count+=1
		      end
		      @count_hash[weekday_arr[i]]=count
		    end
		    
		    @big_weekday=find_big_hsah(@count_hash)
		    
		    for i in 0...weekday_arr.size
		      each_day_hash=Hash.new
		      each_period_count=0
		      weekday_name=""
		      table_entry_re_obj_back_up=nil
		      class_timings.where(:mg_weekday_id=>weekday_arr[i]).order(:start_time).each do |cls|
		          table_entry_obj=MgTimeTableEntry.find_by(:mg_class_timings_id=>cls.id,:is_deleted=>0, :mg_batch_id=>batch_id, :mg_school_id=>mg_school_id, :mg_weekday_id=>weekday_arr[i])
		          
		          if table_entry_obj.present?
		          	table_entry_re_obj_back_up=table_entry_obj
		             table_entry_re_obj=MgTimeTableChangeEntry.find_by(:mg_time_table_entry_id=>table_entry_obj.id,:is_deleted=>0, :mg_school_id=>mg_school_id, :is_permanent=>0)
		             
		            if table_entry_re_obj.present?

		              table_entry_obj=table_entry_re_obj
		            end
		            mg_subject_id=nil
		            if user_type.to_s=='student' && table_entry_re_obj_back_up.mg_elective_group_id.present?
		            	student=MgStudent.find_by(:mg_user_id=>mg_user_id)
		            	mg_subject_id=student.mg_elective_student_associations.where(:mg_elective_group_id=>table_entry_re_obj_back_up.try(:mg_elective_group_id)).pluck(:mg_subject_id)
		            	table_entry_obj=MgTimeTableEntry.find_by(:is_deleted=>0, :mg_batch_id=>table_entry_re_obj_back_up.mg_batch_id, :mg_class_timings_id=>table_entry_re_obj_back_up.mg_class_timings_id, :mg_elective_group_id=>table_entry_re_obj_back_up.mg_elective_group_id,:mg_school_id=>mg_school_id, :mg_subject_id=>mg_subject_id)
		            end
		            # puts "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
		            # puts ""
		            # puts mg_subject_id.inspect
		            # puts ""
		            # puts "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
		            # puts ""
		            
		            each_day_hash[each_period_count+=1]={
		              "subject_name"=>table_entry_re_obj_back_up.try(:mg_elective_group_id).present? && (user_type.to_s!='student') ? each_period_count : table_entry_obj.try(:mg_subject).try(:subject_name),
		              "employee_name"=>table_entry_obj.try(:mg_employee).try(:employee_full_name_with_number),
		              "time"=>cls.try(:start_time).strftime("%k:%M%p").to_s+"-"+cls.try(:end_time).strftime("%k:%M%p").to_s,
		              "employee_number"=>table_entry_obj.try(:mg_employee).try(:employee_number),
		              "mg_elective_group_id"=>(user_type.to_s=='student') ? nil : table_entry_re_obj_back_up.mg_elective_group_id,
		              "elective_group_name"=>MgElectiveGroup.find_by(:id=>table_entry_re_obj_back_up.mg_elective_group_id).try(:name),
		              "room_no"=>table_entry_re_obj_back_up.mg_institute_room.try(:room_no),
		              "mg_batch_id"=>table_entry_re_obj_back_up.try(:mg_batch_id),
		              "mg_class_timings_id"=>table_entry_re_obj_back_up.try(:mg_class_timings_id)

		            }
		          else
		            each_day_hash[each_period_count+=1]={
		              "employee_name"=>"",
		              "subject_name"=>"#{count_else+=' '}",
		              "employee_name"=>"#{count_else+=' '}",
		              "time"=>cls.try(:start_time).strftime("%k:%M%p").to_s+"-"+cls.try(:end_time).strftime("%k:%M%p").to_s,
		              "employee_number"=>"#{count_else+=' '}",
		              "mg_elective_group_id"=>nil,
		              "elective_group_name"=>'',
		              "room_no"=>'',
		              "mg_batch_id"=>nil,
		              "mg_class_timings_id"=>nil
		            }
		          end

		          weekday_name=cls.weekday_name
		      end
		      @timetable[weekday_name]=each_day_hash
		    end
		
		end

	    return [@timetable, @big_weekday]
	end





	def employee_time_table_show(mg_employee_id,mg_school_id, mg_timetable_id)

		    weekday_arr=[]
		    @timetable=Hash.new
		    @big_weekday=nil
		    if mg_timetable_id.present? && mg_school_id.present? && mg_employee_id.present?
			    timetables=MgTimeTableEntry.where(:mg_employee_id=>mg_employee_id,:is_deleted=>0, :mg_school_id => mg_school_id, :mg_timetable_id=>mg_timetable_id)
			    mg_class_timings_id=timetables.pluck(:mg_class_timings_id)
			    class_timings=MgClassTiming.where(:is_deleted=>0, :mg_school_id=>mg_school_id, :is_break=>0, :id=>mg_class_timings_id).includes(:mg_weekday).order("mg_weekdays.weekday asc")
			    weekday_arr=class_timings.pluck(:mg_weekday_id)
			     puts "weekday_arr--->1<---#{weekday_arr.inspect}"
			     weekday_arr=weekday_arr.uniq
			     puts "weekday_arr--->2<---#{weekday_arr.inspect}"
			     
			    @count_hash=Hash.new
			    for i in 0...weekday_arr.size
			      count=0
			      class_timings.where(:mg_weekday_id=>weekday_arr[i]).each do |t_loop|
			        count+=1
			      end
			      @count_hash[weekday_arr[i]]=count
			    end
			    
			     @big_weekday=find_big_hsah(@count_hash)

			     puts "@big_weekday-----> #{@big_weekday.inspect}"
			     
			    for i in 0...weekday_arr.size
			      each_day_hash=Hash.new
			      each_period_count=0
			      weekday_name=""
			      class_timings.where(:mg_weekday_id=>weekday_arr[i]).order(:start_time).each do |cls|
			          table_entry_obj=MgTimeTableEntry.find_by(:mg_class_timings_id=>cls.id,:is_deleted=>0, :mg_school_id=>mg_school_id, :mg_weekday_id=>weekday_arr[i], :mg_employee_id=>mg_employee_id)
			         table_entry_obj_back_up=table_entry_obj
			         if table_entry_obj.present?
			             table_entry_re_obj=MgTimeTableChangeEntry.find_by(:mg_time_table_entry_id=>table_entry_obj.id,:is_deleted=>0, :mg_school_id=>mg_school_id, :is_permanent=>0)
			            if table_entry_re_obj.present?
			              table_entry_obj=table_entry_re_obj
			            end
			            each_day_hash[each_period_count+=1]={
			              "subject_name"=>table_entry_obj.try(:mg_subject).try(:subject_name),
			              "employee_name"=>table_entry_obj.try(:mg_employee).try(:employee_full_name_with_number),
			              "time"=>cls.try(:start_time).strftime("%k:%M%p").to_s+"-"+cls.try(:end_time).strftime("%k:%M%p").to_s,
			              "employee_number"=>table_entry_obj.try(:mg_employee).try(:employee_number),
			              "batch_name"=>table_entry_obj.try(:mg_batch).try(:course_batch_name),
			              "room_no"=>table_entry_obj_back_up.try(:mg_institute_room).try(:room_no)
			            }
			          else

			            each_day_hash[each_period_count+=1]={
			              "subject_name"=>"",
			              "employee_name"=>"",
			              "time"=>cls.try(:start_time).strftime("%k:%M%p").to_s+"-"+cls.try(:end_time).strftime("%k:%M%p").to_s,
			              "employee_number"=>"",
			              "batch_name"=>'',
			              "room_no"=>''
			            }
			          end

			          weekday_name=cls.weekday_name
			      end

			      @timetable[weekday_name]=each_day_hash#sort_according_to_time(each_day_hash)
			    end
			end
		    return [@timetable, @big_weekday]
	end
	def subject_time_table_show(mg_subject_id,mg_school_id, mg_timetable_id)

		    weekday_arr=[]
		    @timetable=Hash.new
		    @big_weekday=nil
		    if mg_timetable_id.present? && mg_school_id.present? && mg_subject_id.present?
			    timetables=MgTimeTableEntry.where(:mg_subject_id=>mg_subject_id,:is_deleted=>0, :mg_school_id => mg_school_id, :mg_timetable_id=>mg_timetable_id)
			    mg_class_timings_id=timetables.pluck(:mg_class_timings_id)
			    class_timings=MgClassTiming.where(:is_deleted=>0, :mg_school_id=>mg_school_id, :is_break=>0, :id=>mg_class_timings_id).includes(:mg_weekday).order("mg_weekdays.weekday asc")
			    weekday_arr=class_timings.pluck(:mg_weekday_id)
			     puts "weekday_arr--->1<---#{weekday_arr.inspect}"
			     weekday_arr=weekday_arr.uniq
			     puts "weekday_arr--->2<---#{weekday_arr.inspect}"
			     
			    @count_hash=Hash.new
			    for i in 0...weekday_arr.size
			      count=0
			      class_timings.where(:mg_weekday_id=>weekday_arr[i]).each do |t_loop|
			        count+=1
			      end
			      @count_hash[weekday_arr[i]]=count
			    end
			    
			     @big_weekday=find_big_hsah(@count_hash)

			     puts "@big_weekday-----> #{@big_weekday.inspect}"
			     
			    for i in 0...weekday_arr.size
			      each_day_hash=Hash.new
			      each_period_count=0
			      weekday_name=""
			      class_timings.where(:mg_weekday_id=>weekday_arr[i]).order(:start_time).each do |cls|
			          table_entry_obj=MgTimeTableEntry.find_by(:mg_class_timings_id=>cls.id,:is_deleted=>0, :mg_school_id=>mg_school_id, :mg_weekday_id=>weekday_arr[i], :mg_subject_id=>mg_subject_id)
			          if table_entry_obj.present?
			          	 table_entry_obj_back_up=table_entry_obj
			             table_entry_re_obj=MgTimeTableChangeEntry.find_by(:mg_time_table_entry_id=>table_entry_obj.id,:is_deleted=>0, :mg_school_id=>mg_school_id, :is_permanent=>0)
			            if table_entry_re_obj.present?
			              table_entry_obj=table_entry_re_obj
			            end
			            each_day_hash[each_period_count+=1]={
			              "subject_name"=>table_entry_obj.mg_subject.try(:subject_name),
			              "employee_name"=>table_entry_obj.mg_employee.try(:employee_full_name_with_number),
			              "time"=>cls.try(:start_time).strftime("%k:%M%p").to_s+"-"+cls.try(:end_time).strftime("%k:%M%p").to_s,
			              "employee_number"=>table_entry_obj.mg_employee.try(:employee_number),
			              "batch_name"=>table_entry_obj.mg_batch.try(:course_batch_name),
			              "room_no"=>table_entry_obj_back_up.try(:mg_institute_room).try(:room_no)
			            }
			          else

			            each_day_hash[each_period_count+=1]={
			              "subject_name"=>"",
			              "employee_name"=>"",
			              "time"=>cls.try(:start_time).strftime("%k:%M%p").to_s+"-"+cls.try(:end_time).strftime("%k:%M%p").to_s,
			              "employee_number"=>"",
			              "batch_name"=>'',
			              "room_no"=>''
			            }
			          end

			          weekday_name=cls.weekday_name
			      end

			      @timetable[weekday_name]=each_day_hash#sort_according_to_time(each_day_hash)
			    end
			end
		    return [@timetable, @big_weekday]
	end

	def find_big_hsah(hash)
		key=[0,0]
		if hash.present?
		  key = hash.sort{|a,b| a[1] <=> b[1]}.last
		  key1=hash.each { |k, v| puts v if v == hash.values.max }
		end
	  return key[1]
	end

end
