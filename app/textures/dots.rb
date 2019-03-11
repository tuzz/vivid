class Dots < Vivid::Texture
  attributes(
    :mapping,
    :uscale,
    :vscale,
    :udelta,
    :vdelta,
    :v1,
    :v2,
    :inside,
    :outside,
  )

  render_as :texture, :dots
end
