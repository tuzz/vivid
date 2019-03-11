class Marble < Vivid::Texture
  attributes :octaves, :roughness, :scale, :variation
  render_as :texture, :marble
end
