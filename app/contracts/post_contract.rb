# frozen_string_literal: true

require "resolv"

class PostContract < Dry::Validation::Contract
  params do
    required(:title).filled(:string)
    required(:text).value(:string)
    required(:user_id).filled(:integer)
    required(:author_ip).filled(:string)
  end

  rule(:user_id) { key.failure("doesn't exists") unless User.where(id: value).exists? }

  rule(:author_ip) do
    key.failure("has incorrect ip address format") unless Resolv::IPv4::Regex === value || Resolv::IPv6::Regex === value
  end
end
