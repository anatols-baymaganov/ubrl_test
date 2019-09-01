# frozen_string_literal: true

module Queries
  class TopPosts < ValidatableService
    DEFAULT_COUNT = 10

    option :count

    class << self
      def call(args)
        super(args.merge(count: args[:count] || DEFAULT_COUNT))
      end

      private

      def contract
        @contract ||= TopPostsContract.new
      end
    end

    private

    def call
      Post.order("avg_score DESC NULLS LAST").first(count)
    end
  end
end
