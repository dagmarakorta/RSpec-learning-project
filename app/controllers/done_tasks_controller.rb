class DoneTasksController < ApplicationController

  def create
    @task = Task.find(params[:task_id])
    @task.update(done: !@task.done)
    redirect_to todolist_path(@task.todolist)
  end
end
