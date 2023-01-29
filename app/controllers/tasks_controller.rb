class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [:edit, :update, :show, :destroy]

  def index
    @tasks = current_user.tasks.order(sort_column + " " + sort_direction)
    @tasks = @tasks.where(status: status_filter) if status_filter
  end

  def new
    @task = Task.new
  end

  def create
    create_task_params = task_params
    create_task_params[:created_by_id] = current_user.id
    unless create_task_params[:assignee_id]
      project = Project.find_by_id(task_params[:project_id])
      create_task_params[:assignee_id] = project.try(:project_lead_id)
    end
    task = Task.new(create_task_params)
    if task.save
      flash[:notice] = 'The task was created successfully'
      redirect_to tasks_path
    else
      flash.now[:notice] = "Error while creating task - #{task.errors.full_messages.join(', ')}"
      @task = Task.new
      render :new
    end
  end

  def edit

  end

  def update
    flash[:notice] = @task.update(task_params) ? 'The task was updated successfully' : 'Error while updating task'
    redirect_to edit_task_path(@task)
  end

  def show
  end

  def destroy
    flash[:notice] = @task.destroy ? 'The task was deleted successfully' : 'Could not delete this task'
    redirect_to tasks_path
  end

  private

  def task_params
    params.require(:task).permit(:summary, :description, :project_id, :status, :assignee_id)
  end

  def set_task
    @task = Task.find_by(id: params[:id])
  rescue
    user_not_authorized
  end

  def sort_column
    Task.column_names.include?(params[:sort]) ? params[:sort] : 'id'
  end

  def status_filter
    Task.statuses.keys.include?(params[:status]) ? params[:status] : nil
  end

end
