# frozen_string_literal: true

class UserInitializeContract < Dry::Validation::Contract
  params do
    required(:login).filled(:string)
  end
end
