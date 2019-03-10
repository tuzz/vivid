class Cone < Vivid::Shape
  attributes :radius, :height, :phimax
  render_as :shape, :cone
  transforms :translate, :rotate, :scale
end
