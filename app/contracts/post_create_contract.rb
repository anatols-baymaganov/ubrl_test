# frozen_string_literal: true

require "resolv"

class PostCreateContract < Dry::Validation::Contract
  params do
    required(:user).filled
    required(:title).filled(:string)
    required(:text).value(:string)
    required(:author_ip).filled(:string)
  end

  rule(:user) { key.failure("should be specified") unless value.is_a?(User) }

  rule(:author_ip) do
    matched = value.match?(Resolv::IPv4::Regex) || value.match?(Resolv::IPv6::Regex)
    key.failure("has incorrect ip address format") unless matched
  end
end
