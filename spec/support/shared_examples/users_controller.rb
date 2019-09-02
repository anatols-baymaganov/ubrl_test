# frozen_string_literal: true

shared_examples "author ips with invalid params" do |params, errors|
  let(:params) { params }

  it "should response with errors" do
    expect(response_body).to match(errors)
  end

  it "should response with status 422" do
    expect(get(:author_ips, params: params)).to have_http_status(422)
  end
end
