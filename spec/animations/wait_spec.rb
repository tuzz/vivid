RSpec.describe Wait do
  let(:scene) { Vivid::Scene.new }
  let(:seconds) { 3 }

  subject { described_class.new(seconds) }

  describe "#update" do
    it "adds the frame_duration to seconds_waited after the first call" do
      d = scene.frame_duration

      subject.update(scene)
      expect(subject.seconds_waited).to eq(0 * d)

      subject.update(scene)
      expect(subject.seconds_waited).to eq(1 * d)

      subject.update(scene)
      expect(subject.seconds_waited).to eq(2 * d)
    end
  end

  describe "#finished?" do
    it "finishes after the specified number of seconds has elapsed" do
      steps = (seconds / scene.frame_duration).to_i

      steps.times { subject.update(scene) }
      expect(subject).not_to be_finished

      subject.update(scene)
      expect(subject).to be_finished
    end

    context "when the number of seconds is mid-way through a frame" do
      let(:seconds) { 3.01 }

      it "finishes on the frame after the requested number of seconds" do
        steps = (seconds / scene.frame_duration).ceil # <-- ceil

        steps.times { subject.update(scene) }
        expect(subject).not_to be_finished

        subject.update(scene)
        expect(subject).to be_finished
      end

      it "can optionally finish on the frame before the number of seconds" do
        subject = described_class.new(at_most: seconds)

        steps = (seconds / scene.frame_duration).floor # <-- floor

        steps.times { subject.update(scene) }
        expect(subject).not_to be_finished

        subject.update(scene)
        expect(subject).to be_finished
      end
    end
  end
end
