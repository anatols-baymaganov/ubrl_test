# frozen_string_literal: true

module Api
  module V1
    class ScoresController < ApplicationController
      def create
        render json: JsonBuilder.response(Creators::Score.call(permitted_params))
      end
    end
  end
end
