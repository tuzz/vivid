class StratifiedSampler < Vivid::Sampler
  attributes :jitter, :xsamples, :ysamples
  render_as :sampler, :stratified
end
