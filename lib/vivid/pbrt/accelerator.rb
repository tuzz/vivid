module Vivid
  class Accelerator
    include Attributes
    include Renderable

    def option_type
      :accelerator
    end

    def self.from_config
      case Vivid.config.accelerator
      when "bvh"
        BvhAccelerator.new
      when "kdtree"
        KdTreeAccelerator.new
      end
    end
  end
end
