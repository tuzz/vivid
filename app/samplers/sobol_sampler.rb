class SobolSampler < Vivid::Sampler
  attributes :pixelsamples
  render_as :sampler, :sobol
end
