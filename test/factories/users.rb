require 'faker'

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6, max_length: 10) }

    trait :with_todolists do
      after :create do |user|
        create_list :todolist, 3, user: user   # has_many
      end
    end
  end
end
