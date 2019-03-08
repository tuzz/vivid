module Vivid
  class Scene
    attr_accessor :world

    def initialize
      self.world = {}
    end

    def add(object)
      return if world.key?(object)

      world[object] = true
      object.next_frame
    end
  end
end
