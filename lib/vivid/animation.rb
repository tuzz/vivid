module Vivid
  class Animation
    EPSILON = 0.00000001 # Helps with floating point precision errors.

    attr_accessor :finished

    def update(scene)
      raise NotImplementedError
    end

    def finished?
      !!finished
    end
  end
end
