# frozen_string_literal: true

RSpec.describe Sidekiq::Enqueuer do
  subject(:all_jobs) { described_class.all_jobs }

  describe "#configure" do
    before do
      described_class.configure do |config|
        config.jobs = [NoParamWorker, HardJob]
      end
    end

    it "holds two jobs" do
      expect(all_jobs.count).to eq(2)
    end

    it "wraps the jobs" do
      expect(all_jobs).to all(be_an_instance_of(Sidekiq::Enqueuer::Worker::Instance))
    end

    it "wrapped jobs are ordered and refer to workers" do
      expect(all_jobs.map(&:name)).to eq(%w[HardJob NoParamWorker])
    end
  end
end
