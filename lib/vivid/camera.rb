module Vivid
  class Camera
    include Attributes
    include Renderable
    include Transformable

    def option_type
      :camera
    end
  end
end
