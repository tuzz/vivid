module Vivid
  class Scene
    attr_accessor :options, :world, :animations, :frame_rate

    def initialize
      self.options = {}
      self.world = {}
      self.animations = []

      set_options_from_config
      set_frame_rate_from_config
    end

    def name
      self.class.name.split("::").last
    end

    def set(object)
      options[object.option_type] = object
    end

    def add(object)
      return if world.key?(object)

      world[object] = true
      object.next_frame
    end

    def play(animation)
      animations << animation
    end

    def frame_duration
      1.0 / frame_rate
    end

    def set_options_from_config
      set Camera.from_config
      set Sampler.from_config
      set Film.from_config
      set Filter.from_config
      set Integrator.from_config
      set Accelerator.from_config
    end

    def set_frame_rate_from_config
      self.frame_rate = Vivid.config.frame_rate
    end
  end
end
