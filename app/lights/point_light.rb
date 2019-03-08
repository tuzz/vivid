class PointLight < Vivid::Light
  attributes :I, :from
  render_as :light_source, :point
  transforms :translate
end
