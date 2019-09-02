# frozen_string_literal: true

shared_examples "post with invalid params" do |params, errors|
  let(:params) { params }

  it "should not create new Post" do
    expect { post(:create, params: params) }.to_not change { Post.count }
  end

  it "should response with status 422" do
    expect(post(:create, params: params)).to have_http_status(422)
  end

  it "should response with errors" do
    expect(response_body).to match(errors)
  end
end

shared_examples "top posts with invalid params" do |params, errors|
  let(:params) { params }

  it "should response with errors" do
    expect(response_body).to match(errors)
  end

  it "should response with status 422" do
    expect(get(:top, params: params)).to have_http_status(422)
  end
end
