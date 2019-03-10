class BdtpIntegrator < Vivid::Integrator
  attributes :maxdepth, :pixelbounds, :lightsamplestrategy, :visualizestrategies, :visualizeweights
  render_as :integrator, :bdpt
end
