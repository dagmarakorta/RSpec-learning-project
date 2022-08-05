class TodolistsController < ApplicationController
  before_action :set_todolist, only: [:show, :edit, :update, :destroy]

  def index
    @todolists = Todolist.where(user: current_user)
  end

  def show
    if @todolist.user == current_user
      @task = Task.new
    else
      redirect_to todolists_path, alert: "This is not your list! You can't see it!"
    end
  end

  def new
    @todolist = Todolist.new
  end

  def create
    form = TodolistForm.new(todolist_params, current_user)
    if form.submit
      redirect_to todolist_path(form.todolist), notice: 'Todolist was successfully created.'
    else
      @error_message = form.errors.full_messages.join(', ')
      @todolist = Todolist.new(todolist_params)
      render :new, alert: "Error: #{@error_message}"
    end
  end

  def edit
    if @todolist.user != current_user
      redirect_to todolists_path, alert: "This is not your list! You can't edit it!"
    end
  end

  def update
    if @todolist.user == current_user
      if @todolist.update(todolist_params)
        redirect_to @todolist
      else
        render :edit
      end
    else
      redirect_to todolists_path, alert: "This is not your list! You can't edit it!"
    end
  end

  def destroy
    if @todolist.user == current_user
      @todolist.destroy
      redirect_to todolists_path, status: :see_other
    else
      redirect_to todolists_path, alert: 'You cannot delete this list!'
    end
  end

  private

  def todolist_params
    params.require(:todolist).permit(:title)
  end

  def set_todolist
    @todolist = Todolist.find(params[:id])
  end
end
