class ImageMap < Vivid::Texture
  attributes(
    :mapping,
    :uscale,
    :vscale,
    :udelta,
    :vdelta,
    :v1,
    :v2,
    :filename,
    :wrap,
    :maxanisotropy,
    :trilinear,
    :scale,
    :gamma,
  )

  render_as :texture, :imagemap
end
