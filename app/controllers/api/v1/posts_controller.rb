# frozen_string_literal: true

module Api
  module V1
    class PostsController < ApplicationController
      def create
        render_json(Creators::Post, permitted_params)
      end

      def top
        render_json(Queries::TopPosts, count: params[:count])
      end

      private

      def permitted_params
        super.merge(author_ip: request.remote_ip)
      end
    end
  end
end
