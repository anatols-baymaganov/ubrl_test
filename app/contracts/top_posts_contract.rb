# frozen_string_literal: true

class TopPostsContract < Dry::Validation::Contract
  params do
    required(:count).filled(:integer, gt?: 0)
  end
end
