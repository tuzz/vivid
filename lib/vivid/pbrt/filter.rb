module Vivid
  class Filter
    include Attributes
    include Renderable

    def option_type
      :filter
    end

    def self.from_config
      case Vivid.config.filter
      when "box"
        BoxFilter.new
      when "gaussian"
        GaussianFilter.new
      when "mitchell"
        MitchellFilter.new
      when "sinc"
        SincFilter.new
      when "triangle"
        TriangleFilter.new
      end
    end
  end
end
