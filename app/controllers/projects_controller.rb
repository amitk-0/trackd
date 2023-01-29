class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!, only: [:index, :new, :create]
  before_action :set_project, only: [:edit, :update, :show, :project_tasks]

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    project = Project.new(project_params)
    if project.save
      flash[:notice] = 'The project was created successfully'
      redirect_to projects_path
    else
      flash.now[:notice] = "Error while creating project - #{project.errors.full_messages.join(', ')}"
      @project = Project.new
      render :new
    end
  end

  def edit
    authorize @project
  end

  def update
    authorize @project
    flash[:notice] = @project.update(project_params) ? 'The project was updated successfully' : 'Error while updating project'
    redirect_to edit_project_path(@project)
  end

  def project_tasks
    authorize @project
    @tasks = @project.tasks.order(task_sort_column + " " + sort_direction)
  end

  private

  def project_params
    params.require(:project).permit(:code, :title, :description, :project_lead_id)
  end

  def set_project
    @project = Project.find_by(id: params[:id])
  rescue
    user_not_authorized
  end

  def task_sort_column
    Task.column_names.include?(params[:sort]) ? params[:sort] : 'id'
  end

end
