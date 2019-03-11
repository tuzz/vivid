class Plastic < Vivid::Material
  attributes :Kd, :Ks, :roughness, :remaproughness
  render_as :material, :plastic
end
