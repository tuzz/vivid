module Vivid
  class Camera
    include Attributes
    include Renderable
    include Transformable

    def option_type
      :camera
    end

    def self.from_config
      case Vivid.config.camera
      when "environment"
        EnvironmentCamera.new
      when "orthographic"
        OrthographicCamera.new
      when "perspective"
        PerspectiveCamera.new
      when "realistic"
        RealisticCamera.new
      end
    end
  end
end
