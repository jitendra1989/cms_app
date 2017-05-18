class MgElectiveTypesController < ApplicationController
  layout "mindcom"
  before_filter :login_required
  def index
    @elective_types=MgElectiveType.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id]).paginate(page: params[:page], per_page: 5)
  end

  def new
    @elective_types=MgElectiveType.new()
    render :layout=>false
  end

  def create
    elective_type=MgElectiveType.new(elective_type_prams)
    if elective_type.save
      redirect_to mg_elective_types_path
    else
      redirect_to :controller=>"mg_elective_types",:action=>"new"
    end

  end

  def edit
    @elective_types=MgElectiveType.find(params[:id])
    render :layout=>false
  end
  
  def update
    elective_type=MgElectiveType.find(params[:id])
    if elective_type.update(elective_type_prams)
      redirect_to mg_elective_types_path
    else
      redirect_to :controller=>"mg_elective_types",:action=>"edit"
    end
  end

  def show
    @elective_type=MgElectiveType.find(params[:id])
    render :layout=>false
  end

  def delete
    @elective_type=MgElectiveType.find(params[:id])
    @elective_type.update(:is_deleted=>1)
  end

  private
  def elective_type_prams
    params.require(:mg_elective_type).permit(:name,:description,:is_deleted,:mg_school_id,:created_by,:updated_by)
  end

end
