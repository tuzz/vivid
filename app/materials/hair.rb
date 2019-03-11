class Hair < Vivid::Material
  attributes :sigma_a, :color, :eumelanin, :pheomelanin, :eta, :beta_m, :beta_n, :alpha
  render_as :material, :hair
end
