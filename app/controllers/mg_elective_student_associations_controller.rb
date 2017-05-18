class MgElectiveStudentAssociationsController < ApplicationController
	layout "mindcom"
	before_filter :login_required
  def index
 
  end

  def subject_list
  	@subjects=MgSubject.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_elective_group_id=>params[:mg_elective_group_id], :mg_course_id=>params[:mg_course_id])
    render :layout=>false   
  end

  def create
    selected_student_ids=params[:selectedStudents]
    students_ids=params[:studentsId]
    puts "Elective Student Params============"
    puts elective_student_params
    if selected_student_ids.present?
      selected_student_ids.each do |selected_student_id|
        elective_student_group=MgElectiveStudentAssociation.where(:mg_school_id=>session[:current_user_school_id],:mg_student_id=>selected_student_id,:mg_elective_group_id=>params[:mg_elective_student_association][:mg_elective_group_id],:mg_subject_id=>params[:mg_elective_student_association][:mg_subject_id])
        if elective_student_group.present?
           elective_student_group[0].update(elective_student_params)
        else
          elective_student_association=MgElectiveStudentAssociation.new(elective_student_params)
          elective_student_association.save
          elective_student_association.update(:mg_student_id=>selected_student_id)
        end
      end
    end
    if students_ids.present?
      students_ids.each do |student_id|
        rejected_student_group=MgElectiveStudentAssociation.where(:mg_school_id=>session[:current_user_school_id],:mg_student_id=>student_id,:mg_elective_group_id=>params[:mg_elective_student_association][:mg_elective_group_id],:mg_subject_id=>params[:mg_elective_student_association][:mg_subject_id])
        if rejected_student_group.present?
          rejected_student_group[0].update(:is_deleted=>1)
        end
      end
    end
    no_of_student_opted=MgElectiveStudentAssociation.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_elective_group_id=>params[:mg_elective_student_association][:mg_elective_group_id],:mg_subject_id=>params[:mg_elective_student_association][:mg_subject_id]).count
    subjects=MgSubject.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_elective_group_id=>params[:mg_elective_student_association][:mg_elective_group_id],:id=>params[:mg_elective_student_association][:mg_subject_id])
    subjects[0].update(:no_of_students_opted=>no_of_student_opted)
    redirect_to mg_elective_student_associations_path
  end

  def show
    @students_lists=MgStudent.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_batch_id=>params[:batch_id]).pluck(:first_name,:id)
    
    assigned_student_ids=MgElectiveStudentAssociation.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_elective_group_id=>params[:mg_elective_group_id],:mg_subject_id=>params[:mg_subject_id]).pluck(:mg_student_id)

    student_asigned_to_elective_group_id=MgElectiveStudentAssociation.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_elective_group_id=>params[:mg_elective_group_id]).pluck(:mg_student_id)

    if assigned_student_ids.length>0
      if student_asigned_to_elective_group_id.length>0
        @new_student_list=MgStudent.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_batch_id=>params[:batch_id]).where("id NOT IN(?)",student_asigned_to_elective_group_id).pluck(:first_name,:id)
      else
        @new_student_list=MgStudent.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_batch_id=>params[:batch_id]).where("id IS NOT NULL").pluck(:first_name,:id)
      end
      @selected_student_list=MgStudent.where("id IN (?)",assigned_student_ids).pluck(:first_name,:id)
    else
      if student_asigned_to_elective_group_id.length>0
        @new_student_list=MgStudent.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_batch_id=>params[:batch_id]).where("id NOT IN(?)",student_asigned_to_elective_group_id).pluck(:first_name,:id)
      else
        @new_student_list=MgStudent.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id],:mg_batch_id=>params[:batch_id]).where("id IS NOT NULL").pluck(:first_name,:id)
      end
      @selected_student_list=[]
    end
	  render :layout=>false 	
  end

  private
  def elective_student_params
    params.require(:mg_elective_student_association).permit(:mg_elective_group_id,:is_deleted,:mg_school_id,:created_by,:updated_by,:mg_subject_id)
  end
end
