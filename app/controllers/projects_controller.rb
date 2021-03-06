class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]


  def index
    @projects = Project.order('position')
    @task = Task.new
    @project = Project.new

  end

  def show
    @project_tasks = @project.tasks.order('completed ASC, name')
  end

  def new
    @project = Project.new
  end

  def edit; end

  def create
    @project = Project.new(project_params)
    respond_to do |format|
      if @project.save
        format.html { redirect_to projects_path, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to projects_path, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def position
    params[:project].each_with_index do |id, index|
      Project.where(id: id).update(position: index + 1)
    end
    render name: nil
  end
  private
    # def set_task
    #   @task = @project.tasks.find(params[:task_id])
    # end
    def set_project
      @project = Project.find(params[:id])
    end
    def project_params
      params.require(:project).permit(:name, :status, :position, :task_id, :project_id)
    end
end
