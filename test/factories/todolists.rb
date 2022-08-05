require 'faker'

FactoryBot.define do
  factory :todolist do
    title { Faker::Coffee.blend_name } # sorry, was not sure what other faker to use here, this one looked nice)
    user

    trait :with_tasks do
      after :create do |todolist|
        create_list :task, 3, todolist: todolist
      end
    end
  end
end
