class TriangleFilter < Vivid::Filter
  attributes :xwidth, :ywidth
  render_as :pixel_filter, :triangle
end
