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

  def option_type
    :film
  end
end
