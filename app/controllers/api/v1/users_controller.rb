# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      def author_ips
        render_json(Queries::AuthorIps, logins: params[:logins])
      end
    end
  end
end
