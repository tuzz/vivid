module Vivid
  RSpec.describe Config do
    it "defines a config method on Vivid" do
      expect(Vivid.config.path).to eq("config/test.yml")
    end

    it "loads its config from a yaml file" do
      previous = described_class.path

      Tempfile.create do |file|
        file.write({ foo: "bar" }.to_yaml)
        file.close

        described_class.path = file.path
        expect(described_class.foo).to eq("bar")
      end

    ensure
      described_class.path = previous
    end
  end
end
