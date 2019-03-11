class Matte < Vivid::Material
  attributes :Kd, :sigma
  render_as :material, :matte
end
