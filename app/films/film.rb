class Film
  include Vivid::Attributes
  include Vivid::Renderable

  render_as :film, :image

  attributes(
    :xresolution, :yresolution,
    :cropwindow,
    :scale,
    :maxsampleluminance,
    :diagonal,
    :filename,
  )
end
