class LoopSubdivision < Vivid::Shape
  attributes :levels, :indices, :P
  render_as :shape, :loopsubdiv
  transforms :translate, :rotate, :scale
end
