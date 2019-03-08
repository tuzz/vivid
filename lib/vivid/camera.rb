module Vivid
  class Camera
    include Attributes
    include Renderable
    include Transformable

    attributes :shutteropen, :shutterclose
    transforms :translate
  end
end
