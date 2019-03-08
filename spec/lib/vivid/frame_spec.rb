module Vivid
  RSpec.describe Frame do
    describe "#render" do
      it "uses pbrt to render the frame to an image" do
        file = Tempfile.new(["foo", ".png"])
        film = Film.new(filename: file.path, xresolution: 50, yresolution: 50)

        sphere = Sphere.new.translate(0, 0, 2)
        light = PointLight.new

        [film, sphere, light].each(&:next_frame)

        subject = described_class.new([film], [sphere, light])
        subject.render

        expect(File.size(file.path)).to be > 500
      ensure
        file.unlink
      end
    end

    describe "#set_path" do
      let(:film) { Film.new }
      subject { described_class.new([film], []) }

      class FrameTest
      end

      it "sets the top-level directory from global config" do
        subject.set_path(FrameTest.new, 3)
        expect(film.filename).to start_with("test-output/")
      end

      it "sets the sub-directory from the namespace's class" do
        subject.set_path(FrameTest.new, 3)
        expect(film.filename).to include("/FrameTest/")
      end

      it "sets the filename from the frame number" do
        subject.set_path(FrameTest.new, 3)
        expect(film.filename).to include("/frame-00000003.png")
      end

      class FrameTest::FrameTest2
      end

      it "removes ancestors when it embeds the namespace's class" do
        subject.set_path(FrameTest::FrameTest2.new, 3)
        expect(film.filename).to include("/FrameTest2/")
      end

      class FrameTest3
        def name
          "my_custom_name"
        end
      end

      it "uses the #name from the namespace if it has one" do
        subject.set_path(FrameTest3.new, 3)
        expect(film.filename).to eq("test-output/my_custom_name/frame-00000003.png")
      end
    end

    describe "#pbrt_file" do
      it "writes the scene description to a file and yields it" do
        sphere = Sphere.new
        sphere.next_frame

        subject = described_class.new([], [sphere])

        subject.pbrt_file do |file|
          expect(File.read(file.path)).to eq(<<~PBRT)
            WorldBegin
            AttributeBegin
            Shape "sphere"
            AttributeEnd
            WorldEnd
          PBRT
        end
      end
    end

    describe "#build_pbrt" do
      it "builds the scene options, followed by the world definition" do
        camera = PerspectiveCamera.new
        sphere = Sphere.new
        light = PointLight.new

        [camera, sphere, light].each(&:next_frame)

        subject = described_class.new([camera], [sphere, light])
        builder = PBRT::Builder.new

        subject.build_pbrt(builder)

        expect(builder.to_s).to eq(<<~PBRT)
          Camera "perspective"
          WorldBegin
          AttributeBegin
          Shape "sphere"
          AttributeEnd
          AttributeBegin
          LightSource "point"
          AttributeEnd
          WorldEnd
        PBRT
      end
    end
  end
end
