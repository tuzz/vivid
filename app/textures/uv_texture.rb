class UvTexture < Vivid::Texture
  attributes :mapping, :uscale, :vscale, :udelta, :vdelta, :v1, :v2
  render_as :texture, :uv
end
