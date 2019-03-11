module Vivid
  RSpec.describe Sampler do
    describe ".from_config" do
      it "sets the number of pixel samples" do
        subject = Sampler.from_config

        expect(subject.pixelsamples).to eq(Config.pixelsamples)
      end
    end
  end
end
