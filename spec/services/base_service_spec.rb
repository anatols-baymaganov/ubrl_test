# frozen_string_literal: true

require "rails_helper"

Rails.describe BaseService, type: :service do
  describe ".call" do
    it { expect { described_class.call({}) }.to raise_error(NotImplementedError) }
  end

  describe "#call" do
    it { expect { described_class.new.send(:call) }.to raise_error(NotImplementedError) }
  end
end
