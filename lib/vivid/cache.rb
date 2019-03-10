module Vivid
  class Cache
    attr_accessor :input_path, :output_path

    def initialize(input_path:, output_path:)
      self.input_path = input_path
      self.output_path = output_path
    end

    def fetch
      if File.exists?(cache_output_path)
        FileUtils.cp(cache_output_path, output_path)
      else
        yield

        FileUtils.mkdir_p(Vivid.config.cache)
        FileUtils.cp(input_path, cache_input_path)
        FileUtils.cp(output_path, cache_output_path)
      end

      FileUtils.cp(input_path, "#{output_path}.pbrt")
    end

    def cache_input_path
      "#{Vivid.config.cache}/#{fingerprint}.pbrt"
    end

    def cache_output_path
      "#{Vivid.config.cache}/#{fingerprint}#{File.extname(output_path)}"
    end

    def fingerprint
      @fingerprint ||= Exec.md5(path: input_path)
    end
  end
end
