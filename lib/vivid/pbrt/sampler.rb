module Vivid
  class Sampler
    include Attributes
    include Renderable

    def option_type
      :sampler
    end

    def self.from_config
      case Vivid.config.sampler
      when "halton"
        HaltonSampler.new(pixelsamples: Vivid.config.pixelsamples)
      end
    end
  end
end
