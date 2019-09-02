# frozen_string_literal: true

require "rails_helper"

Rails.describe JsonBuilder, type: :service do
  describe ".call" do
    context "when service is undefined" do
      let(:params) { [nil, {}] }
      let(:result) { described_class.call(*params) }

      it "should return result with status 422" do
        expect(result[:status]).to eq(422)
      end
    end
  end
end
