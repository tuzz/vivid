module Vivid
  class Integrator
    include Attributes
    include Renderable

    def option_type
      :integrator
    end

    def self.from_config
      case Vivid.config.integrator
      when "bdtp"
        BdtpIntegrator.new
      when "directlighting"
        DirectLightingIntegrator.new
      when "mlt"
        MltIntegrator.new
      when "path"
        PathIntegrator.new
      when "sppm"
        SppmIntegrator.new
      when "whitted"
        WhittedIntegrator.new
      end
    end
  end
end
