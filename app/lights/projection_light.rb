class ProjectionLight < Vivid::Light
  attributes :scale, :I, :fov, :mapname
  render_as :light_source, :projection
  transforms :translate, :rotate
end
