# frozen_string_literal: true

class BaseService
  extend Dry::Initializer

  def self.call(_args)
    raise NotImplementedError
  end

  private

  def call
    raise NotImplementedError
  end
end
