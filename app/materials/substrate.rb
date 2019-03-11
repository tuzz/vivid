class Substrate < Vivid::Material
  attributes :Kd, :Ks, :uroughness, :vroughness, :remaproughness
  render_as :material, :substrate
end
