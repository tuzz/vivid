class KdTreeAccelerator < Vivid::Accelerator
  attributes :intersectcost, :traversalcost, :emptybonus, :maxprims, :maxdepth
  render_as :accelerator, :kdtree
end
