class GaussianFilter < Vivid::Filter
  attributes :xwidth, :ywidth, :alpha
  render_as :pixel_filter, :gaussian
end
