class Disney < Vivid::Material
  attributes(
    :color,
    :anisotropic,
    :clearcoat,
    :clearcoatgloss,
    :eta,
    :metallic,
    :roughness,
    :scatterdistance,
    :sheen,
    :sheentint,
    :spectrans,
    :speculartint,
    :thin,
    :difftrans,
    :flatness,
  )

  render_as :material, :disney
end
