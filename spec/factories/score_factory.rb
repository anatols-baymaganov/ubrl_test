# frozen_string_literal: true

FactoryBot.define do
  factory :score do
    post
    value { rand(1..5) }
  end
end
