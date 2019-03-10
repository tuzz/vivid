class Disk < Vivid::Shape
  attributes :height, :radius, :innerradius, :phimax
  render_as :shape, :disk
  transforms :translate, :rotate, :scale
end
