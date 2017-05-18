class MgSubjectTypesController < ApplicationController
 layout "mindcom"
 before_filter :login_required
  def index
    @subject_types=MgSubjectType.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id]).paginate(page: params[:page], per_page: 5)
  end

  def edit
    @subject_type=MgSubjectType.find(params[:id])
    render :layout => false
  end

  def new
    render :layout => false
  end

  def create
    subject_type=MgSubjectType.new(subject_type_prams)
    if subject_type.save
      redirect_to :controller=>"mg_subject_types",:action=>"index"
    else
      redirect_to :controller=>"mg_subject_types",:action=>"edit"
    end

  end

  def update
    @subject_type=MgSubjectType.find(params[:id])
    @subject_type.update(subject_type_prams)
    redirect_to :controller=>"mg_subject_types",:action=>"index"
  end

  def destroy
    subject_type=MgSubjectType.find(params[:id])
    subject_type.update(:is_deleted=>1)
    redirect_to mg_subject_types_path
    # redirect_to :controller=>"mg_subject_types",:action=>"index"
  end

  def show
    @subject_type=MgSubjectType.find(params[:id])
    render :layout => false
  end

  private
  def subject_type_prams
    params.require(:subject_type).permit(:name,:description,:is_deleted,:mg_school_id,:created_by,:updated_by)
  end
end
