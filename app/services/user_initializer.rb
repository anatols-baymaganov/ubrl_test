# frozen_string_literal: true

class UserInitializer < ValidatableService
  option :login

  def self.contract
    @contract ||= UserInitializeContract.new
  end

  private_class_method :contract

  private

  def call
    User.find_or_initialize_by(login: login)
  end
end
