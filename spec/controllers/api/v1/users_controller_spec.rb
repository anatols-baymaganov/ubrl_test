# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::UsersController, type: :controller do
  describe "#author_ips" do
    let(:response_body) { JSON.parse(get(:author_ips, params: params).body) }
    let!(:users) { create_list(:user, 5) }

    context "when parameters are valid" do
      let!(:ips) { (1..5).map { Faker::Internet.ip_v4_address } }
      let!(:posts) { (1..20).map { create(:post, user: users.sample, author_ip: ips.sample ) } }
      let(:params) { { logins: users.pluck(:login) } }
      let(:expected_json) do
        posts.group_by(&:author_ip).map do |ip, posts|
          { "ip" => ip.to_s, "logins" => posts.map { |p| p.user.login }.uniq.sort }
        end
      end
      let(:received_json) { response_body.each { |row| row["logins"].sort! } }

      it "should response with IPs JSON" do
        expect(received_json).to match_array(expected_json)
      end

      it "should response with status 200" do
        expect(get(:author_ips, params: params)).to have_http_status(200)
      end
    end

    context "when parameters are invalid" do
      [
        {
          message: "when logins is missing",
          params: {},
          errors: { "logins" => ["must be an array"] }
        },
        {
          message: "when logins is not array",
          params: { logins: "text" },
          errors: { "logins" => ["must be an array"] }
        },
        {
          message: "when some logins empty",
          params: { logins: [nil, "login1"] },
          errors: { "logins" => { "0" => ["must be filled"] } }
        }
      ].each do |cntxt|
        context cntxt[:message] do
          it_behaves_like "author ips with invalid params", cntxt[:params], cntxt[:errors]
        end
      end

      context "when some requested users doesn't exist" do
        let(:invalid_logins) { %w[login1 login2] }
        let(:params) { { logins: users.pluck(:login) + invalid_logins } }

        it "should response with errors" do
          expect(response_body).to match({ "logins" => ["users with next logins don't exist: #{invalid_logins}"] })
        end

        it "should response with status 422" do
          expect(get(:author_ips, params: params)).to have_http_status(422)
        end
      end
    end
  end
end
