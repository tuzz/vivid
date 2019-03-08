module Vivid
  class Scene
    attr_accessor :options, :world

    def initialize
      self.options = {}
      self.world = {}

      set_options_from_config
    end

    def set(object)
      options[object.option_type] = object
    end

    def add(object)
      return if world.key?(object)

      world[object] = true
      object.next_frame
    end

    def set_options_from_config
      set Camera.from_config
      set Sampler.from_config
      set Film.from_config
      set Filter.from_config
      set Integrator.from_config
      set Accelerator.from_config
    end
  end
end
