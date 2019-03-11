class Mixture < Vivid::Material
  attributes :amount, :namedmaterial1, :namedmaterial2
  render_as :material, :mixture
end
