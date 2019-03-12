class Cylinder < Vivid::Shape
  attributes :radius, :zmin, :zmax, :phimax
  render_as :shape, :cylinder
  transforms :translate, :rotate, :scale

  include Vivid::Materialistic
end
