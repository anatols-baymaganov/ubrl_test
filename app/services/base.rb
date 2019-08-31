# frozen_string_literal: true

class Base
  extend Dry::Initializer

  def self.call(_args)
    raise NotImplementedError
  end

  def call
    raise NotImplementedError
  end
end
