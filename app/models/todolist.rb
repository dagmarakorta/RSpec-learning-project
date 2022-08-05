class Todolist < ApplicationRecord
  MIN_TITLE_LENGTH = 5
  has_many :tasks, dependent: :destroy
  belongs_to :user
  validates :title, presence: true, length: { minimum: MIN_TITLE_LENGTH }

  def capitalize_title
    title.capitalize!
  end
end
