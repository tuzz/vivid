module Vivid
  RSpec.describe Scene do
    describe "#initialize" do
      it "sets the scene options from global config" do
        options = subject.options.values

        expect(options).to include(TransformTimes)
        expect(options).to include(PerspectiveCamera)
        expect(options).to include(HaltonSampler)
        expect(options).to include(BoxFilter)
        expect(options).to include(PathIntegrator)
        expect(options).to include(BvhAccelerator)
      end
    end

    describe "#name" do
      class Scene::SceneTest < Scene
      end

      it "returns the name of the class without the namespace" do
        subject = Scene::SceneTest.new

        expect(subject.name).to eq("SceneTest")
      end
    end

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

        options = subject.options.values

        expect(options).not_to include(perspective)
        expect(options).to include(orthographic)
      end

      it "does not override options of other types" do
        perspective = PerspectiveCamera.new
        subject.set(perspective)

        film = Film.new
        subject.set(film)

        options = subject.options.values

        expect(options).to include(perspective)
        expect(options).to include(film)
      end

      it "errors if the object is not an option" do
        sphere = Sphere.new

        expect { subject.set(sphere) }.to raise_error(/option_type/)
      end

      it "calls #next_frame on the option when it is set" do
        perspective = PerspectiveCamera.new
        builder = PBRT::Builder.new

        expect { perspective.build_pbrt(builder) }.to raise_error(SequenceError)

        subject.set(perspective)
        perspective.build_pbrt(builder)
      end
    end

    describe "#play" do
      it "adds an animation to the queue" do
        sphere = Sphere.new
        appear = Appear.new(sphere)

        subject.play(appear)
        expect(subject.animations).to eq [appear]
      end
    end

    describe "#frame_duration" do
      it "delegates to the TransformTimes option" do
        subject.set TransformTimes.new(frame_rate: 10)
        expect(subject.frame_duration).to eq(0.1)

        subject.set TransformTimes.new(frame_rate: 20)
        expect(subject.frame_duration).to eq(0.05)
      end
    end

    describe "#finished?" do
      it "returns true when there are no animations left" do
        subject.animations = [:foo]
        expect(subject).not_to be_finished

        subject.animations.clear
        expect(subject).to be_finished
      end
    end

    describe "#update_animation" do
      class TestAnimation < Struct.new(:count)
        def update(scene)
          self.count ||= 0
          self.count += 1
        end

        def finished?
          count == 2
        end
      end

      it "updates the first animation in the sequence" do
        animation1 = TestAnimation.new
        animation2 = TestAnimation.new

        subject.animations = [animation1, animation2]
        subject.update_animation

        expect(animation1.count).to eq(1)
        expect(animation2.count).to be_nil
      end

      it "removes an animation once it has finished" do
        animation = TestAnimation.new
        subject.animations = [animation]

        subject.update_animation

        expect(animation).not_to be_finished
        expect(subject.animations).not_to be_empty

        subject.update_animation

        expect(subject.animations).to be_empty
      end

      it "starts the next animation as soon as one finishes" do
        animation1 = TestAnimation.new
        animation2 = TestAnimation.new

        subject.animations = [animation1, animation2]

        subject.update_animation
        subject.update_animation

        expect(animation1.count).to eq(2)
        expect(animation2.count).to eq(1)
      end
    end
  end
end
