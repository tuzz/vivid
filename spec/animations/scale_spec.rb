RSpec.describe Scale do
  let(:scene) { Vivid::Scene.new }
  let(:target) { Sphere.new }

  subject { described_class.new(target, by: [1, 2, 4], duration: 2) }

  describe "#update" do
    it "adds the target to the scene" do
      expect { subject.update(scene) }
        .to change { scene.world.include?(target) }
        .from(false)
        .to(true)
    end

    it "scales the target based on the scene's frame duration" do
      # There are 10 frames in 2 seconds, so each step should be 10%
      expect(Vivid.config.frame_rate * 2).to eq(10)

      subject.update(scene)

      expect(target.scale_transform[0]).to eq(1)
      expect(target.scale_transform[1]).to be_within(0.01).of(1.07)
      expect(target.scale_transform[2]).to be_within(0.01).of(1.15)

      9.times { subject.update(scene) }

      expect(target.scale_transform[0]).to eq(1)
      expect(target.scale_transform[1]).to be_within(0.01).of(2)
      expect(target.scale_transform[2]).to be_within(0.01).of(4)
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
