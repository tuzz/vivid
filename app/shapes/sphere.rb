class Sphere < Vivid::Shape
  attributes :radius, :zmin, :zmax, :phimax
  render_as :shape, :sphere
  transforms :translate, :rotate, :scale

  include Vivid::Materialistic
end
