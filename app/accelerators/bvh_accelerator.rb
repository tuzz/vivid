class BvhAccelerator < Vivid::Accelerator
  attributes :maxnodeprims, :splitmethod
  render_as :accelerator, :bvh
end
