module Vivid
  RSpec.describe Film do
    describe ".from_config" do
      it "sets the resolution of the image" do
        subject = Film.from_config

        expect(subject.xresolution).to eq(Config.resolution[0])
        expect(subject.yresolution).to eq(Config.resolution[1])
      end

      it "sets the filename of the image" do
        subject = Film.from_config

        expect(subject.filename).to eq(Config.filename)
      end
    end
  end
end
