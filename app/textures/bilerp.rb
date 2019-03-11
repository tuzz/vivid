class Bilerp < Vivid::Texture
  attributes(
    :mapping,
    :uscale,
    :vscale,
    :udelta,
    :vdelta,
    :v1,
    :v2,
    :v00,
    :v01,
    :v10,
    :v11,
  )

  render_as :texture, :bilerp
end
