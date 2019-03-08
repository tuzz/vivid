class HaltonSampler < Vivid::Sampler
  attributes :pixelsamples
  render_as :sampler, :halton
end
