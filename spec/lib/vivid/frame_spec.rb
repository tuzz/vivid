module Vivid
  RSpec.describe Frame do
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
