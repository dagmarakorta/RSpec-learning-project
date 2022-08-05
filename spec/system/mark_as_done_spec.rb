require 'rails_helper'

RSpec.describe 'Marks task as done', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:todolist) { FactorBot.create(:todolist, user: user) }
  let(:task) { FactoryBot.create(:task, todolist: todolist) }

  scenario 'success' do
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'
      visit todolist_path(task.todolist)
      click_on '✔️'
      expect(page).to have_content '[X]'
  end
end
