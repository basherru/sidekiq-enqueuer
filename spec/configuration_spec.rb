# frozen_string_literal: true

RSpec.describe Sidekiq::Enqueuer::Configuration do
  describe "#all_jobs" do
    subject { config.all_jobs }

    before { config.jobs = [NoParamWorker, HardWorker] }

    let(:config) { described_class.new }

    it { is_expected.to eq([HardWorker, NoParamWorker]) }
  end
end
