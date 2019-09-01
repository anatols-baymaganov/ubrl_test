# frozen_string_literal: true

module Api
  module V1
    class ScoresController < ApplicationController
      def create
        render_json(Creators::Score, permitted_params)
      end
    end
  end
end
