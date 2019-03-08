module Vivid
  class Shape
    include Attributes
    include Renderable
    include Transformable

    transforms :translate, :rotate, :scale
  end
end
