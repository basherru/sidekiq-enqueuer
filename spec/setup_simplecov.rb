# frozen_string_literal: true

require "simplecov"

# SimpleCov.enable_coverage(:line)
# SimpleCov.enable_coverage(:branch)
#
# SimpleCov.minimum_coverage(line: 100, branch: 100)
#
# SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
#   SimpleCov::Formatter::HTMLFormatter,
#   Coveralls::SimpleCov::Formatter,
# ])
#
# SimpleCov.add_filter("/lib/sidekiq/enqueuer/views/")
# SimpleCov.add_filter("/lib/sidekiq/enqueuer/locales/")
# SimpleCov.add_filter("/spec/")

SimpleCov.configure do
  enable_coverage :line
  enable_coverage :branch

  minimum_coverage line: 100, branch: 100

  formatter SimpleCov::Formatter::MultiFormatter.new([
    SimpleCov::Formatter::HTMLFormatter,
    Coveralls::SimpleCov::Formatter,
  ])

  add_group "Worker", "/lib/enqueuer/worker/"
  add_group "WebExtension", "/lib/enqueuer/web_extension/"

  add_filter "/lib/sidekiq/enqueuer/views/"
  add_filter "/lib/sidekiq/enqueuer/locales/"
  add_filter "/spec/"
end
