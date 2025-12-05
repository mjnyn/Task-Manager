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

    if @task.save
      flash.now[:notice] = "Task created."
    else
      flash.now[:alert] = "Task not created. Ensure title is populated."
    end

    @todo_tasks = Task.where(completed: false).order(updated_at: :desc)
    @completed_tasks = Task.where(completed: true).order(updated_at: :desc)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to tasks_path, notice: flash[:notice] || flash[:alert] }
    end
  end

  def destroy
    @task.destroy!
    @todo_tasks = Task.where(completed: false).order(updated_at: :desc)
    @completed_tasks = Task.where(completed: true).order(updated_at: :desc)
    flash.now[:notice] = "Task deleted."

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to tasks_path, notice: flash[:notice] }
    end
  end

  def complete
    @task = Task.find(params[:id])
    @task.update(completed: true)

    @todo_tasks = Task.where(completed: false).order(updated_at: :desc)
    @completed_tasks = Task.where(completed: true).order(updated_at: :desc)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to tasks_path }
    end
  end

  def incomplete
    @task = Task.find(params[:id])
    @task.update(completed: false)
    @todo_tasks = Task.where(completed: false).order(updated_at: :desc)
    @completed_tasks = Task.where(completed: true).order(updated_at: :desc)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to tasks_path }
    end
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:title).merge(completed: false)
    end
end
