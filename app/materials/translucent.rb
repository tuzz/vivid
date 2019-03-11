class Translucent < Vivid::Material
  attributes :Kd, :Ks, :reflect, :transmit, :roughness, :remaproughness
  render_as :material, :translucent
end
