class WhittedIntegrator < Vivid::Integrator
  attributes :maxdepth, :pixelbounds
  render_as :integrator, :whitted
end
