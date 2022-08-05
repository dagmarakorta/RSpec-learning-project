require 'rails_helper'

RSpec.describe 'Done Tasks Controller', type: :request do

  describe "#create" do
    let(:url) { "/todolists/#{todolist.id}/tasks/#{task.id}/done_tasks" }
    let(:todolist) { FactoryBot.create(:todolist) }
    let(:task) { FactoryBot.create(:task, done: false, todolist: todolist) }
    before { sign_in(todolist.user) }

    it "marks the task as done" do
      expect{ post url }.to change{ task.reload.done }.from(false).to(true)
    end

    it "redirects to the todolist page" do
      post url
      expect(response).to redirect_to(todolist_url(todolist))
    end
  end
end
