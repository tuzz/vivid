class Fbm < Vivid::Texture
  attributes :octaves, :roughness
  render_as :texture, :fbm
end
