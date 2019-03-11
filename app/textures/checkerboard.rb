class Checkerboard < Vivid::Texture
  attributes(
    :mapping,
    :uscale,
    :vscale,
    :udelta,
    :vdelta,
    :v1,
    :v2,
    :dimension,
    :tex1,
    :tex2,
    :aamode,
  )

  render_as :texture, :checkerboard
end
