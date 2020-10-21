# frozen_string_literal: true

require "simplecov"
require "coveralls"
require "bundler/setup"
require "pry"
require "active_job"
require "rack/test"
require "sidekiq"
require "sidekiq/api"
require "sidekiq/enqueuer"
require "timecop"

require_relative "support/definitions"

ENV["RACK_ENV"] = "test" # skip Rack Protection
REDIS = Sidekiq::RedisConnection.create(url: "redis://localhost/15")
Sidekiq.logger.level = Logger::ERROR

ActiveJob::Base.queue_adapter = :sidekiq
ActiveJob::Base.logger.level = Logger::ERROR

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter,
])

SimpleCov.start do
  add_filter "spec/"
end

Dir["#{__dir__}/../lib/sidekiq/**/*.rb"].sort.each { |f| require f }

RSpec.configure do |config|
  config.example_status_persistence_file_path = ".rspec_status"
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
