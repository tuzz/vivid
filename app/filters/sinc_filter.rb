class SincFilter < Vivid::Filter
  attributes :xwidth, :ywidth, :tau
  render_as :pixel_filter, :sinc
end
