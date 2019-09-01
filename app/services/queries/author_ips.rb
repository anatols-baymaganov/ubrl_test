# frozen_string_literal: true

module Queries
  class AuthorIps < ValidatableService
    option :logins

    def self.contract
      @contract ||= AuthorIpsContract.new
    end

    private_class_method :contract

    private

    def call
      Post.joins(:user).where(users: { login: logins }).group(:author_ip).pluck(:author_ip, "ARRAY_AGG(login)")
          .map do |grouped|
        { ip: grouped.first.to_s, logins: grouped.second.uniq }
      end
    end
  end
end
