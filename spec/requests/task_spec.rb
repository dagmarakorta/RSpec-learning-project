require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  describe "#delete", type: :request do
    let(:url) { "/todolists/#{todolist.id}/tasks/#{task.id}" }
    let(:todolist) { FactoryBot.create(:todolist) }
    let!(:task) { FactoryBot.create(:task, done: false, todolist: todolist) }

    context 'when user is logged in' do
      it "allows user to delete the task" do
        sign_in(todolist.user)
        expect{ delete url }.to change{ todolist.reload.tasks.count }.from(1).to(0)
      end
    end

    context 'when user is not logged in' do
      it "redirects to the sign_in page" do
        delete url
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe '#create', type: :request do
    let(:url) { "/todolists/#{todolist.id}/tasks" }
    let(:todolist) { FactoryBot.create(:todolist) }
    let (:task) { FactoryBot.build(:task) }

    context 'when user is logged in' do
      it "creates a new task" do
        sign_in(todolist.user)
        expect{ post url, params: { task: task.attributes } }.to change{ todolist.reload.tasks.count }.from(0).to(1)
      end
    end

    context 'when user is not logged in' do
      it "redirects to the sign_in page" do
        post url
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
