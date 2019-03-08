module Vivid
  class Scene
    attr_accessor :options, :world

    def initialize
      self.options = {}
      self.world = {}
    end

    def set(object)
      options[object.option_type] = object
    end

    def add(object)
      return if world.key?(object)

      world[object] = true
      object.next_frame
    end
  end
end
