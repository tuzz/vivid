class Subsurface < Vivid::Material
  attributes :name, :sigma_a, :sigma_prime_s, :scale, :eta, :Kr, :Kt, :uroughness, :vroughness, :remaproughness
  render_as :material, :subsurface
end
