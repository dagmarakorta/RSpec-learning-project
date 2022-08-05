class Task < ApplicationRecord
  belongs_to :todolist
  validates :description, presence: true
end
