class MitchellFilter < Vivid::Filter
  attributes :xwidth, :ywidth, :B, :C
  render_as :pixel_filter, :mitchell
end
