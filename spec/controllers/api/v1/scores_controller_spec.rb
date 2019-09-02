# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::ScoresController, type: :controller do
  describe "#create" do
    let(:response_body) { JSON.parse(post(:create, params: params).body) }
    let!(:persisted_post) { create(:post, :with_scores) }

    context "when parameters are valid" do
      let!(:scores) { persisted_post.scores.to_a }
      let!(:score_value) { rand(1..5) }
      let!(:new_avg_score) { ((scores.pluck(:value).sum + score_value) / scores.count.next.to_f).round(1) }
      let(:params) { { post_id: persisted_post.id, value: score_value } }

      it "should create new Score" do
        expect{ post(:create, params: params) }.to change { persisted_post.scores.count }.from(scores.count).to(scores.count.next)
      end

      it "should recalculate Post's avg_score" do
        post(:create, params: params)
        expect(persisted_post.reload.avg_score.round(1)).to eq(new_avg_score)
      end

      it "should response with new avg_score" do
        expect(response_body).to include("avg_score" => new_avg_score)
      end

      it "should response with status 200" do
        expect(post(:create, params: params)).to have_http_status(200)
      end
    end

    context "when parameters are invalid" do
      [
        {
          message: "when value is missing",
          params: { post_id: :existed },
          errors: { "value" => ["is missing"] }
        },
        {
          message: "when value is not integer",
          params: { post_id: :existed, value: "text" },
          errors: { "value" => ["must be an integer"] }
        },
        {
          message: "when value is less than 1",
          params: { post_id: :existed, value: 0 },
          errors: { "value"=>["must be greater than or equal to 1"] }
        },
        {
          message: "when value is greater than 5",
          params: { post_id: :existed, value: 6 },
          errors: { "value"=>["must be less than or equal to 5"] }
        },
        {
          message: "when post_id is missing",
          params: { value: 5 },
          errors: { "post_id" => ["is missing"] }
        },
        {
          message: "when post_id is not integer",
          params: { post_id: "text", value: 5 },
          errors: { "post_id"=>["must be an integer"] }
        },
        {
          message: "when Post with post id doesn't exist",
          params: { post_id: :not_existed, value: 5 },
          errors: { "post_id"=>["doesn't exist"] }
        }
      ].each do |cntxt|
        context cntxt[:message] do
          it_behaves_like "score with invalid params", cntxt[:params], cntxt[:errors]
        end
      end
    end
  end
end
