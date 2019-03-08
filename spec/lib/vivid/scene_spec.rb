module Vivid
  RSpec.describe Scene do
    describe "#add" do
      it "adds an object to the scene" do
        sphere = Sphere.new

        subject.add(sphere)

        expect(subject.world).to include(sphere)
      end

      it "does not add the same object more than once" do
        sphere1 = Sphere.new
        sphere2 = Sphere.new

        subject.add(sphere1)
        subject.add(sphere2)
        subject.add(sphere2)

        expect(subject.world.size).to eq(2)
      end

      it "calls #next_frame on the object when it is added" do
        sphere = Sphere.new
        builder = PBRT::Builder.new

        expect { sphere.build_pbrt(builder) }.to raise_error(SequenceError)

        subject.add(sphere)
        sphere.build_pbrt(builder)
      end
    end
  end
end
