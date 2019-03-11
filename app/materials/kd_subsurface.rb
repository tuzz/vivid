class KdSubsurface < Vivid::Material
  attributes :Kd, :mfp, :eta, :Kr, :Kt, :uroughness, :vroughness, :remaproughness
  render_as :material, :kdsubsurface
end
