class AddUserReferencesToTodolist < ActiveRecord::Migration[7.0]
  def change
    add_reference :todolists, :user, foreign_key: true
  end
end
