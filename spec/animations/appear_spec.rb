RSpec.describe Appear do
  let(:scene) { Vivid::Scene.new }
  let(:target) { Sphere.new }

  subject { described_class.new(target) }

  describe "#update" do
    it "adds the target to the scene" do
      expect { subject.update(scene) }
        .to change { scene.world.include?(target) }
        .from(false)
        .to(true)
    end
  end

  describe "#finished?" do
    it "finishes after #update is called" do
      expect { subject.update(scene) }
        .to change { subject.finished? }
        .from(false)
        .to(true)
    end
  end
end
