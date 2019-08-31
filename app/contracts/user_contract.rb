# frozen_string_literal: true

class UserContract < Dry::Validation::Contract
  params do
    required(:login).filled(:string)
  end

  rule(:login) { key.failure("must be unique") if User.where(login: value).exists? }
end
