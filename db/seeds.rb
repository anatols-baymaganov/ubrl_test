# frozen_string_literal: true

require "faker"
require "ruby-progressbar"

user_logins = (1..100).map { Faker::Internet.unique.username }
author_ips = (1..50).map { Faker::Internet.unique.ip_v4_address }
posts_count = 200_000
progress = ProgressBar.create(total: posts_count, format: "%a %b\u{15E7}%i %p%% %t",
                              progress_mark: " ", remainder_mark: "\u{FF65}")

posts_count.times do
  post = Creators::Post.call(login: user_logins.sample, title: Faker::Lorem.word,
                             text: Faker::Lorem.paragraph, author_ip: author_ips.sample)
  raise post.to_h unless post.is_a?(Post)

  rand(6).times do
    res = Creators::Score.call(post_id: post.id, value: rand(1..5))
    raise res.to_h unless res.is_a?(Score)
  end

  progress.increment
end
