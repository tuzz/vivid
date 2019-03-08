class Sphere < Vivid::Shape
  attributes :radius, :zmin, :zmax, :phimax
  render_as :shape, :sphere
end
