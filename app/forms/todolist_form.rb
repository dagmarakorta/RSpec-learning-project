class TodolistForm
  include ActiveModel::Model

  attr_accessor :title
  attr_reader :todolist

  validates :title, presence: true, length: {
    minimum: Todolist::MIN_TITLE_LENGTH,
    message: "Title is too short (minimum is #{Todolist::MIN_TITLE_LENGTH} characters)"
  }

  def initialize(params, user)
    @title = params[:title]
    @user = user
  end

  def submit
    return false unless valid?
    create_todolist!
  end

  private

  def create_todolist!
    @todolist = Todolist.create!(title: @title, user: @user)
  end
end
