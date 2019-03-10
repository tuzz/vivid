class MltIntegrator < Vivid::Integrator
  attributes :maxdepth, :bootstrapsamples, :chains, :mutationsperpixel, :largestepprobability, :sigma
  render_as :integrator, :mlt
end
