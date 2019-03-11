module Vivid
  class Sampler
    include Attributes
    include Renderable

    def option_type
      :sampler
    end

    def self.from_config
      samples = Vivid.config.pixelsamples

      case Vivid.config.sampler
      when "halton"
        HaltonSampler.new(pixelsamples: samples)
      when "maxmindist"
        MaxMinDistSampler.new(pixelsamples: samples)
      when "random"
        RandomSampler.new(pixelsamples: samples)
      when "sobol"
        SobolSampler.new(pixelsamples: samples)
      when "02sequence"
        ZeroTwoSequenceSampler.new(pixelsamples: samples)
      when "stratified"
        StratifiedSampler.new(xsamples: samples, ysamples: samples)
      end
    end
  end
end
