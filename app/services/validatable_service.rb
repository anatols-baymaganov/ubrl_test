# frozen_string_literal: true

class ValidatableService < BaseService
  class << self
    def call(args)
      validation_res = contract.call(args)
      return validation_res.errors if validation_res.errors.any?

      new(validation_res.to_h).send(:call)
    end

    def contract
      raise NotImplementedError
    end
  end

  private

  def call
    raise NotImplementedError
  end
end
