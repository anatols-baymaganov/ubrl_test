# frozen_string_literal: true

class ScoreContract < Dry::Validation::Contract
  params do
    required(:post_id).filled(:integer)
    required(:value).filled(:integer, gteq?: 1, lteq?: 5)
  end

  rule(:post_id) { key.failure("doesn't exist") unless Post.where(id: value).exists? }
end
