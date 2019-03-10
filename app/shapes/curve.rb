class Curve < Vivid::Shape
  attributes :P, :basis, :degree, :type, :N, :width, :width0, :width1, :splitdepth
  render_as :shape, :curve
  transforms :translate, :rotate, :scale
end
