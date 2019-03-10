class HeightField < Vivid::Shape
  attributes :nu, :nv, :Pz
  render_as :shape, :heightfield
  transforms :translate, :rotate, :scale
end
