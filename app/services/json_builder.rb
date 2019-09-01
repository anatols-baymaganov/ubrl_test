# frozen_string_literal: true

class JsonBuilder < BaseService
  option :service
  option :args

  class << self
    def call(subject)
      new(subject: subject).send(:call)
    end
    alias response call
  end

  private

  def call
    case subject
    when Dry::Validation::MessageSet then response_json(422, subject.to_h)
    when Post then response_json(200, subject.as_json(except: :author_ip).merge(author_ip: subject.author_ip.to_s))
    when Score then response_json(200, avg_score: subject.post.avg_score.round(1))
    else response_json(200, subject.as_json)
    end
  end

  def response_json(status, body = {})
    body.merge(status: status)
  end
end
