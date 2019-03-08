class PathIntegrator < Vivid::Integrator
  attributes :maxdepth, :pixelbounds, :rrthreshold, :lightsamplestrategy
  render_as :integrator, :path
end
