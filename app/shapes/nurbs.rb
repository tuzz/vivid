class Nurbs < Vivid::Shape
  attributes :nu, :nv, :uorder, :vorder, :uknots, :vknots, :u0, :v0, :u1, :v1, :P, :Pw
  render_as :shape, :nurbs
  transforms :translate, :rotate, :scale

  include Vivid::Materialistic
end
