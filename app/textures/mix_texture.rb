class MixTexture < Vivid::Texture
  attributes :tex1, :tex2, :amount
  render_as :texture, :mix
end
