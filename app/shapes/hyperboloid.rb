class Hyperboloid < Vivid::Shape
  attributes :p1, :p2, :phimax
  render_as :shape, :hyperboloid
  transforms :translate, :rotate, :scale
end
