class TasksController < ApplicationController
  before_action :set_task, only: %i[ show destroy ]

  def index
    @tasks = Task.all
    @todo_tasks = Task.where(completed: false).order(updated_at: :desc)
    @completed_tasks = Task.where(completed: true).order(updated_at: :desc)
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        redirect_to tasks_path, notice: "Task created."
      else
        redirect_to tasks_path, alert: "Task could not be created."
      end
    end
  end

  def destroy
    @task.destroy!

    respond_to do |format|
      format.html { redirect_to tasks_path, notice: "Task was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  def complete
    @task = Task.find(params[:id])
    @task.update(completed: true)
    redirect_to tasks_path, notice: "Task marked complete."
  end

  def incomplete
    @task = Task.find(params[:id])
    @task.update(completed: false)
    redirect_to tasks_path, notice: "Task marked incompleted."
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:title).merge(completed: false)
    end
end
