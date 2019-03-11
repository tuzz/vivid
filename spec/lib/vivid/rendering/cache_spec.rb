module Vivid
  RSpec.describe Cache do
    let(:input) { Tempfile.new }
    let(:output) { Tempfile.new(["", ".png"]) }

    before do
      input.write("foo")
      input.close
    end

    after do
      input.unlink
      output.unlink
    end

    subject do
      described_class.new(input_path: input.path, output_path: output.path)
    end

    let(:md5) { "acbd18db4cc2f85cedef654fccc4a4d8" }

    describe "#fetch" do
      context "when the rendered image is in the cache" do
        before do
          FileUtils.mkdir_p(Vivid.config.cache)
          File.write("#{subject.cache_output_path}", "cached content")
        end

        it "does not call the block" do
          subject.fetch { raise "this should not be called" }
        end

        it "copies the cached output file to the output path" do
          subject.fetch { }

          content = File.read(output.path)
          expect(content).to eq("cached content")
        end

        it "copies the input file to sit alongside the output file (useful as reference)" do
          FileUtils.rm_f("#{output.path}.pbrt")

          subject.fetch { }

          copied_input = File.read("#{output.path}.pbrt")
          expect(copied_input).to eq("foo")
        end
      end

      context "when the rendered image is not in the cache" do
        before { FileUtils.rm_rf(Vivid.config.cache) }

        it "calls the block" do
          subject.fetch do
            output.write("rendered image")
            output.close
          end

          content = File.read(output.path)
          expect(content).to eq("rendered image")
        end

        it "copies the rendered image to its cache path" do
          subject.fetch do
            output.write("rendered image")
            output.close
          end

          cached_output = File.read(subject.cache_output_path)
          expect(cached_output).to eq("rendered image")
        end

        it "copies the input file to its cache path (useful as reference)" do
          subject.fetch do
            output.write("rendered image")
            output.close
          end

          cached_input = File.read(subject.cache_input_path)
          expect(cached_input).to eq("foo")
        end

        it "copies the input file to sit alongside the output file (useful as reference)" do
          FileUtils.rm_f("#{output.path}.pbrt")

          subject.fetch do
            output.write("rendered image")
            output.close
          end

          copied_input = File.read("#{output.path}.pbrt")
          expect(copied_input).to eq("foo")
        end
      end
    end

    describe "#cache_input_path" do
      it "returns the path for where to store the input file" do
        expect(subject.cache_input_path).to eq("test-output/_cache/#{md5}.pbrt")
      end
    end

    describe "#cache_output_path" do
      it "returns the path for where to store the output file" do
        expect(subject.cache_output_path).to eq("test-output/_cache/#{md5}.png")
      end
    end

    describe "#fingerprint" do
      it "returns the md5 of the content at the input_path" do
        expect(subject.fingerprint).to eq(md5)
      end
    end
  end
end
