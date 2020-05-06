class TasksController < ApplicationController
  before_action :set_project
  before_action :set_task, except: [:create]

  def new
    @task = Task.new
  end

  def edit; end

  def create
    @task = @project.tasks.create(task_params)
    if @task.save
      redirect_to projects_path, notice: 'Task was successfully created.'
    else
      redirect_to projects_path, notice: 'Can not be empty'
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to projects_path, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task = @project.tasks.find(params[:id])
    if @task.destroy
      redirect_to projects_path
    else
      redirect_to projects_path
    end
  end

  def completed
    @task.update(completed: true)
    redirect_to projects_path
  end

  def uncompleted
    @task.update(completed: false)
    redirect_to projects_path
  end

  private
    def set_project
      @project = Project.find(params[:project_id])
    end
    def set_task
      @task = @project.tasks.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:name, :deadline, :position)
    end
end
