# frozen_string_literal: true

module Api
  module V1
    class PostsController < ApplicationController
      def create
        render json: JsonBuilder.response(Creators::Post.call(permitted_params))
      end

      private

      def permitted_params
        super.merge(author_ip: request.remote_ip)
      end
    end
  end
end
