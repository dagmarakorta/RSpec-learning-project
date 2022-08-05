require 'rails_helper'

RSpec.describe Todolist, type: :model do
  describe 'validations' do
    let (:todolist) { FactoryBot.build(:todolist, title: title) }
    let (:title) { 'my todolist' } # par default
    it "is valid with valid attributes" do
      # expect(Todolist.new(title: 'Test title')).to be_valid
      expect(todolist.valid?).to eq(true)
    end

    context 'when title is blank' do
      let (:title) { '' }
      it "is not valid without a title" do
        expect(todolist.valid?).to eq(false)
      end
    end

    context 'when title is too short' do
      let (:title) { 'a' }
      it "is not valid with a short title" do
        expect(todolist.valid?).to eq(false)
      end
    end
  end

  describe '#capitalize_title' do
    let (:todolist) { FactoryBot.build(:todolist, title: 'my todolist') }
    it 'capitalizes first letter of title' do
      todolist.capitalize_title
      expect(todolist.title).to eq('My todolist')
    end
  end

  describe '#dependant_destroy' do
    let (:todolist) { FactoryBot.create(:todolist, :with_tasks) }
    it 'destroys all tasks when deleted' do
      todolist.destroy
      expect(Task.where(todolist_id: todolist.id).count).to eq(0)
    end
  end
end
