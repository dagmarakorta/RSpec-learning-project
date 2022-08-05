require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    let (:user) { FactoryBot.build(:user) }
    it 'is valid with a valid email and password' do
      expect(user.valid?).to eq(true)
    end

    context 'when email is not valid' do
      let (:user) { FactoryBot.build(:user, email: 'a') }
      it 'is not valid with an invalid email' do
        expect(user.valid?).to eq(false)
      end
    end

    context 'when email is blank' do
      let (:user) { FactoryBot.build(:user, email: '') }
      it 'is not valid without an email' do
        expect(user.valid?).to eq(false)
      end
    end

    context 'when password is invalid' do
      let (:user) { FactoryBot.build(:user, password: 'one') }
      it 'is not valid with an short password' do
        expect(user.valid?).to eq(false)
      end
    end

    context 'when password is blank' do
      let (:user) { FactoryBot.build(:user, password: '') }
      it 'is not valid without a password' do
        expect(user.valid?).to eq(false)
      end
    end
  end

  describe "#dependent_destroy" do
    it 'destroys all todolists when deleted' do
      user = User.create(email: 'test@test.fr', password: 'secret')
      Todolist.create(title: 'Test title', user_id: user.id)
      id = user.id
      user.destroy
      expect(Todolist.where(user_id: id).count).to eq(0)
    end
  end
end
