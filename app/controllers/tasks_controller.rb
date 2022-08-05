class TasksController < ApplicationController
  before_action :set_task, only: [:destroy, :mark_as_done!]
  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.todolist_id = params[:todolist_id]
    @task.save
    redirect_to todolist_path(@task.todolist)
  end

  def destroy
    @task.destroy
    redirect_to todolist_path(@task.todolist), status: :see_other
  end

  private

  def task_params
    params.require(:task).permit(:description, done: false)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
