require 'faker'

FactoryBot.define do
  factory :task do
    description { Faker::Verb.base }
    done { false }
    todolist
  end
end
