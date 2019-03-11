class ScaleTexture < Vivid::Texture
  attributes :tex1, :tex2
  render_as :texture, :scale
end
