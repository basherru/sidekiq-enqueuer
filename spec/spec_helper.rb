# frozen_string_literal: true

require "active_job"
require "bundler/setup"
require "coveralls"
require "pry"
require "rack/test"
require "sidekiq"
require "sidekiq/api"
require "sidekiq/enqueuer"
require "sidekiq/web"
require "simplecov"
require "timecop"

require_relative "./setup_simplecov"

ENV["RACK_ENV"] = "test" # skip Rack Protection
REDIS = Sidekiq::RedisConnection.create(url: "redis://localhost/15")
Sidekiq.logger.level = Logger::ERROR

ActiveJob::Base.queue_adapter = :sidekiq
ActiveJob::Base.logger.level = Logger::ERROR

SimpleCov.start

Dir["#{__dir__}/../lib/sidekiq/**/*.rb"].sort.each { |f| require f }
Dir["#{__dir__}/support/**/*.rb"].sort.each { |x| require x }

RSpec.configure do |config|
  config.example_status_persistence_file_path = ".rspec_status"
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
