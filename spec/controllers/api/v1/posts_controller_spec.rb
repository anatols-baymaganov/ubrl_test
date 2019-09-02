# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::PostsController, type: :controller do
  describe "#create" do
    let(:response_body) { JSON.parse(post(:create, params: params).body) }

    context "when parameters are valid" do
      let(:user_login) { Faker::Internet.unique.username }
      let(:params) { { login: user_login, title: Faker::Lorem.word, text: Faker::Lorem.paragraph } }

      context "and user doesn't exists" do
        it "should create new User" do
          expect { post(:create, params: params) }.to change { User.last&.login }.to(user_login)
        end
      end

      context "and user already exists" do
        let!(:user) { create(:user, login: user_login) }

        it "should not create new User" do
          expect { post(:create, params: params) }.not_to change { User.count }
        end
      end

      it "should response with status 200" do
        expect(post(:create, params: params)).to have_http_status(200)
      end

      it "should create new Post" do
        expect { post(:create, params: params) }.to change { Post.count }.from(0).to(1)
      end

      it "should response with Post fields" do
        expect(response_body).to include(Post.last.attributes)
      end
    end

    context "when parameters are invalid" do
      [
        {
          message: "when login is missing",
          params: { title: "title", text: "text" },
          errors: { "login" => ["is missing"] }
        },
        {
          message: "when title is missing",
          params: { login: "login", text: "text" },
          errors: { "title" => ["is missing"] }
        },
        {
          message: "when text is missing",
          params: { login: "login", title: "title" },
          errors: { "text" => ["is missing"] }
        },
        {
          message: "when login is empty",
          params: { login: "", title: "title", text: "text" },
          errors: { "login" => ["must be filled"] }
        },
        {
          message: "when title is empty",
          params: { login: "login", title: "", text: "text" },
          errors: { "title" => ["must be filled"] }
        },
        {
          message: "when text is empty",
          params: { login: "login", title: "title", text: "" },
          errors: { "text" => ["must be filled"] }
        }
      ].each do |cntxt|
        context cntxt[:message] do
          it_behaves_like "post with invalid params", cntxt[:params], cntxt[:errors]
        end
      end
    end
  end

  describe "#top" do
    let(:response_body) { JSON.parse(get(:top, params: params).body) }

    context "when parameters are valid" do
      let!(:posts) { create_list(:post, top_count + rand(1..3), :with_scores) }
      let(:expected_titles) { Post.order("avg_score DESC NULLS LAST").first(top_count).pluck(:title) }
      let(:top_titles) { response_body.map { |post| post["title"] } }

      context "and count is specified" do
        let(:top_count) { rand(15..20) }
        let(:params) { { count: top_count } }

        it "should return top Posts by avg_score" do
          expect(top_titles).to match(expected_titles)
        end
      end

      context "and count is not specified" do
        let(:top_count) { Queries::TopPosts::DEFAULT_COUNT }
        let(:params) { {} }

        it "should return default count of top Posts by avg_score" do
          expect(top_titles).to match(expected_titles)
        end
      end
    end

    context "when parameters are invalid" do
      [
        {
          message: "when count is not number",
          params: { count: "text" },
          errors: { "count" => ["must be an integer"] }
        },
        {
          message: "when count less or equal zero",
          params: { count: -rand(10) },
          errors: { "count" => ["must be greater than 0"] }
        }
      ].each do |cntxt|
        context cntxt[:message] do
          it_behaves_like "top posts with invalid params", cntxt[:params], cntxt[:errors]
        end
      end
    end
  end
end
