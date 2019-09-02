# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    user
    title { Faker::Lorem.word }
    text { Faker::Lorem.paragraph }
    author_ip { Faker::Internet.ip_v4_address }

    trait :with_scores do
      after(:create) do |post|
        rand(1..3).times { create(:score, post: post) }
      end
    end
  end
end
