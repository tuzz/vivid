RSpec.describe Translate do
  let(:scene) { Vivid::Scene.new }
  let(:target) { Sphere.new }

  subject { described_class.new(target, by: [4, 0, 0], duration: 2) }

  describe "#update" do
    it "adds the target to the scene" do
      expect { subject.update(scene) }
        .to change { scene.world.include?(target) }
        .from(false)
        .to(true)
    end

    it "translates the target based on the scene's frame duration" do
      # There are 10 frames in 2 seconds, so each step should be 10%
      expect(Vivid.config.frame_rate * 2).to eq(10)

      subject.update(scene)
      expect(target.translate_transform).to eq [0.4, 0, 0]
    end
  end

  describe "#finished?" do
    it "finishes after the expected number of steps" do
      9.times { subject.update(scene) }
      expect(subject).not_to be_finished

      subject.update(scene)
      expect(subject).to be_finished
    end
  end
end
