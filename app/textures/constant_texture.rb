class ConstantTexture < Vivid::Texture
  attributes :value
  render_as :texture, :constant
end
