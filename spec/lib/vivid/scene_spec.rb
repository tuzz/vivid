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

    describe "#set" do
      it "sets an option of the scene" do
        camera = PerspectiveCamera.new

        subject.set(camera)

        expect(subject.options.values).to include(camera)
      end

      it "overrides an option of the same type" do
        perspective = PerspectiveCamera.new
        subject.set(perspective)

        orthographic = OrthographicCamera.new
        subject.set(orthographic)

        objects = subject.options.values

        expect(objects).not_to include(perspective)
        expect(objects).to include(orthographic)
      end

      it "does not override options of other types" do
        perspective = PerspectiveCamera.new
        subject.set(perspective)

        film = Film.new
        subject.set(film)

        objects = subject.options.values

        expect(objects).to include(perspective)
        expect(objects).to include(film)
      end

      it "errors if the object is not an option" do
        sphere = Sphere.new

        expect { subject.set(sphere) }.to raise_error(/option_type/)
      end
    end
  end
end
