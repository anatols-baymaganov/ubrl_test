# frozen_string_literal: true

module Creators
  class Post < ValidatableService
    option :user
    option :title
    option :text
    option :author_ip

    class << self
      def call(args)
        res = UserInitializer.call(args)
        return res unless res.is_a?(User)

        super(args.merge(user: res))
      end

      private

      def contract
        @contract ||= PostCreateContract.new
      end
    end

    private

    def call
      ::Post.create(user: user, title: title, text: text, author_ip: author_ip)
    end
  end
end
