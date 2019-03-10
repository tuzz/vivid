class DirectLightingIntegrator < Vivid::Integrator
  attributes :strategy, :maxdepth, :pixelbounds
  render_as :integrator, :directlighting
end
