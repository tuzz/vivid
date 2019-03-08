module Vivid
  RSpec.describe TransformTimes do
    describe ".from_config" do
      it "sets the start time and end time of the transforms" do
        subject = TransformTimes.from_config

        expect(subject.start_time).to eq(0)
        expect(subject.end_time).to eq(1.0 / Vivid.config.frame_rate)
      end
    end

    it "updates the end time when its frame rate changes" do
      subject.frame_rate = 10

      expect(subject.end_time).to eq(0.1)
    end

    it "aliases #frame_duration to #end_time" do
      subject.frame_rate = 10

      expect(subject.frame_duration).to eq(subject.end_time)
    end
  end
end
