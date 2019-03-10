class Paraboloid < Vivid::Shape
  attributes :radius, :zmin, :zmax, :phimax
  render_as :shape, :paraboloid
  transforms :translate, :rotate, :scale
end
