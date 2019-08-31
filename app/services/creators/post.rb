# frozen_string_literal: true

module Creators
  class Post < Base
    option :user
    option :title
    option :text
    option :author_ip

    class << self
      def call(args)
        user = User.find_or_initialize_by(login: args.delete(:login))
        super(args.merge(user: user))
      end

      private

      def contract
        @contract ||= PostContract.new
      end
    end

    private

    def call
      ::Post.create(user: user, title: title, text: text, author_ip: author_ip)
    end
  end
end
