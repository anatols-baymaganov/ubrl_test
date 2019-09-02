# frozen_string_literal: true

shared_examples "score with invalid params" do |params, errors|
  let(:params) do
    case params[:post_id]
    when :existed then params.merge(post_id: persisted_post.id)
    when :not_existed then params.merge(post_id: persisted_post.id.next)
    else params
    end
  end

  it "should not create new Score" do
    expect { post(:create, params: params) }.to_not change { Score.count }
  end

  it "should response with status 422" do
    expect(post(:create, params: params)).to have_http_status(422)
  end

  it "should response with errors" do
    expect(response_body).to match(errors)
  end
end
