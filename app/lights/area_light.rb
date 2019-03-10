class AreaLight < Vivid::Light
  attributes :L, :twosided, :samples
  render_as :area_light_source, :diffuse
  transforms :translate, :rotate, :scale
end
