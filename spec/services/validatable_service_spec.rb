# frozen_string_literal: true

require "rails_helper"

Rails.describe ValidatableService, type: :service do
  describe ".contract" do
    it { expect { described_class.contract }.to raise_error(NotImplementedError) }
  end

  describe "#call" do
    it { expect { described_class.new.send(:call) }.to raise_error(NotImplementedError) }
  end
end
