# frozen_string_literal: true

RSpec.shared_context "web extension api context" do
  include Rack::Test::Methods

  subject(:app) { Sidekiq::Web }
end
