class MgElectiveGroupsController < ApplicationController
  layout "mindcom"
  before_filter :login_required
  def index
    @elective_groups=MgElectiveGroup.where(:is_deleted=>0,:mg_school_id=>session[:current_user_school_id]).paginate(page: params[:page], per_page: 5)
  end

  def new
    @elective_group=MgElectiveGroup.new
    render :layout=>false
  end

  def create
    elective_group=MgElectiveGroup.new(elective_group_prams)
    elective_group.save
    redirect_to mg_elective_groups_path
  end

  def edit
    @elective_group=MgElectiveGroup.find(params[:id])
    render :layout=>false
  end

  def update
    @elective_group=MgElectiveGroup.find(params[:id])
    @elective_group.update(elective_group_prams)
    redirect_to mg_elective_groups_path
  end

  def show
    @elective_group=MgElectiveGroup.find(params[:id])
    render :layout=>false
  end

  def destroy
    elective_group=MgElectiveGroup.find(params[:id])
    elective_group.update(:is_deleted=>1)

  end

  private
  def elective_group_prams
    params.require(:mg_elective_group).permit(:max_weekly_class,:name,:description,:mg_elective_type_id,:is_deleted,:mg_school_id,:created_by,:updated_by)
  end

end
