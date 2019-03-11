class Metal < Vivid::Material
  attributes :eta, :k, :roughness, :uroughness, :vroughness, :remaproughness
  render_as :material, :metal
end
