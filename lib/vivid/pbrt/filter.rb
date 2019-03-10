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
      end
    end
  end
end
