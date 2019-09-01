# frozen_string_literal: true

class AuthorIpsContract < Dry::Validation::Contract
  schema do
    required(:logins).array(:filled?, :str?)
  end

  rule(:logins) do
    passed_logins = value.uniq
    persisted_logins = User.where(login: value).pluck(:login).sort
    not_existed = passed_logins - persisted_logins
    key.failure("users with next logins don't exist: #{not_existed}") if not_existed.any?
  end
end
