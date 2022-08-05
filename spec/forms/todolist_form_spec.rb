require 'rails_helper'

RSpec.describe TodolistForm do
  subject { described_class.new(params, user) }
  let(:user) { FactoryBot.create(:user) }
  let(:title) { "My Todolist" }
  let(:params) do
    {
      title: title
    }
  end
  describe "#submit" do
    context "validations" do
      context "with valid params" do
        it "returns true" do
          expect(subject.submit).to be_truthy
        end
      end

      context "with invalid params" do
        context "when title is too short (less than #{::Todolist::MIN_TITLE_LENGTH} characters)" do
          let(:title) { "My" }
          it "returns false" do
            expect(subject.submit).to be_falsey
          end

          it "adds an error message" do
            subject.submit
            expect(subject.errors.full_messages).to include("Title Title is too short (minimum is 5 characters)")
          end
        end
      end
    end

    context "submission effect" do
      it "creates a Todolist instance" do
        expect { subject.submit }.to change { Todolist.count }.by(1)
      end
    end
  end
end
