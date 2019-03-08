module Vivid
  class Animation
    attr_accessor :finished

    def update(scene)
      raise NotImplementedError
    end

    def finished?
      !!finished
    end
  end
end
