class Uber < Vivid::Material
  attributes :Kd, :Ks, :Kr, :Kt, :roughness, :uroughness, :vroughness, :eta, :opacity, :remaproughness
  render_as :material, :uber
end
