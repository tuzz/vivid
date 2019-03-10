class PlyMesh < Vivid::Shape
  attributes :filename, :alpha, :shadowalpha
  render_as :shape, :plymesh
  transforms :translate, :rotate, :scale
end
