class Glass < Vivid::Material
  attributes :Kr, :Kt, :eta, :uroughness, :vroughness, :remaproughness
  render_as :material, :glass
end
