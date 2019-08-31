# frozen_string_literal: true

module Creators
  class Score < Base
    option :post_id
    option :value

    def self.contract
      @contract ||= ScoreContract.new
    end

    private_class_method :contract

    private

    def call
      ::Score.create(post_id: post_id, value: value)
    end
  end
end
