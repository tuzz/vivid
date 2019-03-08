class PointLight < Vivid::Light
  attributes :scale, :I, :from
  render_as :light_source, :point
  transforms :translate
end
