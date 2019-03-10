class SppmIntegrator < Vivid::Integrator
  attributes :maxdepth, :iterations, :photonsperiteration, :imagewritefrequency, :radius
  render_as :integrator, :sppm
end
