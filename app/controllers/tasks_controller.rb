class TasksController < ApplicationController
  before_action :set_project
  before_action :set_task, except: [:create, :edit]

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = @project.tasks.create(task_params)
    respond_to do |format|
      if @task.save
        format.html { redirect_to @project, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { redirect_to @project, notice: 'Can not be empty'  }

      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task = @project.tasks.find(params[:id])
    if @task.destroy
      redirect_to @project
    else
      redirect_to @project
    end
    # respond_to do |format|
    #   format.html { redirect_to @project, notice: 'Task was successfully destroyed.' }
    #   format.json { head :no_content }
  end

  def done
    @task.update_attribute(:done_at, Time.now)
    redirect_to @project
  end

  def undone
    @task.update_attribute(:done_at, Time.now)
    redirect_to @project
  end
  private
    def set_project
      @project = Project.find(params[:project_id])
    end
    def set_task
      @task = @project.tasks.find(params[:id])
    end
    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:name)
    end
end
