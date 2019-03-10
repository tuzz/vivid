class TriangleMesh < Vivid::Shape
  attributes :indices, :P, :N, :S, :uv, :alpha, :shadowalpha
  render_as :shape, :trianglemesh
  transforms :translate, :rotate, :scale
end
