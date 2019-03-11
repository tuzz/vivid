module Vivid
  module Materialistic
    def self.included(klass)
      klass.before_render(:render_material)
    end

    attr_accessor :material

    def render_material(builder)
      return unless material

      material.next_frame
      material.build_pbrt(builder)
    end
  end
end
