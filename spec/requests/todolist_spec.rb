require 'rails_helper'

RSpec.describe "Todolists", type: :request do
  describe "#delete", type: :request do
    let(:url) { "/todolists/#{todolist.id}" }
    let(:user) { FactoryBot.create(:user) }
    let(:todolist) { FactoryBot.create(:todolist, user: user) }

    context 'when user is logged in' do
      it "allows user to delete his todolist" do
        sign_in(todolist.user)
        expect{ delete url }.to change{ user.reload.todolists.count }.from(1).to(0)
      end
    end

    context 'when user is not logged in' do
      it "redirects to the sign_in page" do
        delete url
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
