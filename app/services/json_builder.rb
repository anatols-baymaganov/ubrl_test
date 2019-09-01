# frozen_string_literal: true

class JsonBuilder < BaseService
  option :service
  option :args

  class << self
    def call(service, args)
      new(service: service, args: args).send(:call)
    end
    alias response call
  end

  private

  def call
    subject = service.call(args)
    return response_json(subject.to_h, 422) if subject.is_a?(Dry::Validation::MessageSet)

    case service.name
    when "Creators::Post" then response_json(subject.as_json.merge(author_ip: subject.author_ip.to_s))
    when "Creators::Score" then response_json(avg_score: subject.post.reload.avg_score.round(1))
    when "Queries::TopPosts" then response_json(subject.map { |post| post.slice(:title, :text) })
    when "Queries::AuthorIps" then response_json(subject)
    else response_json(subject.as_json)
    end
  end

  def response_json(body, status = 200)
    { json: body, status: status }
  end
end
