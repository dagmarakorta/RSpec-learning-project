require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'validations' do
    let (:task) { FactoryBot.build(:task, description: description) }
    let (:description) { 'my task' }
    it "is valid with valid attributes" do
      expect(task.valid?).to eq(true)
    end

    context 'when description is blank' do
      let (:description) { '' }
      it "is not valid without a description" do
        expect(task.valid?).to eq(false)
      end
    end

    context 'when todolist_id is missing' do
      let (:task) { FactoryBot.build(:task, todolist_id: nil) }
        it "is not valid without a todolist" do
        expect(task.valid?).to eq(false)
      end
    end
  end
end
