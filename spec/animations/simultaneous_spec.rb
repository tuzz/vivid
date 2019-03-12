RSpec.describe Simultaneous do
  let(:scene) { Vivid::Scene.new }
  let(:target) { Sphere.new }

  describe "#update" do
    it "updates the animations at the same time" do
      animation1 = Translate.new(target, by: [1, 0, 0], duration: 2)
      animation2 = Translate.new(target, by: [0, 1, 0], duration: 4)

      subject = described_class.new(animation1, animation2)

      # There are 20 frames in 4 seconds
      expect(Vivid.config.frame_rate * 4).to eq(20)

      subject.update(scene)
      expect(target.translate_transform).to eq [0.1, 0.05, 0]

      subject.update(scene)
      expect(target.translate_transform).to eq [0.2, 0.1, 0]
    end
  end

  describe "#finished?" do
    it "becomes true after all animations have finished" do
      animation1 = Translate.new(target, by: [1, 0, 0], duration: 2)
      animation2 = Translate.new(target, by: [0, 1, 0], duration: 4)

      subject = described_class.new(animation1, animation2)

      19.times { subject.update(scene) }
      expect(subject).not_to be_finished

      subject.update(scene)
      expect(subject).to be_finished
    end
  end
end
