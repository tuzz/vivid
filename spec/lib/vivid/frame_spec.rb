module Vivid
  RSpec.describe Frame do
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
