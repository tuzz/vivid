class BoxFilter < Vivid::Filter
  attributes :xwidth, :ywidth
  render_as :pixel_filter, :box
end
