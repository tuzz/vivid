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

  def self.from_config
    self.new(
      xresolution: Vivid.config.resolution[0],
      yresolution: Vivid.config.resolution[1],
      filename: Vivid.config.filename,
    )
  end
end
