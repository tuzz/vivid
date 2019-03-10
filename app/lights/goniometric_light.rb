class GoniometricLight < Vivid::Light
  attributes :scale, :I, :mapname
  render_as :light_source, :goniometric
  transforms :translate, :rotate
end
