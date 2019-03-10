module Vivid
  class Integrator
    include Attributes
    include Renderable

    def option_type
      :integrator
    end

    def self.from_config
      case Vivid.config.integrator
      when "path"
        PathIntegrator.new
      end
    end
  end
end
