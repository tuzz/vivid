module Vivid
  module Renderable
    def self.included(klass)
      klass.extend(ClassMethods)
    end

    def to_pbrt(builder)
      methods = self.class.render_names

      chain = methods[0..-2].inject(builder) do |builder, name|
        builder.public_send(name)
      end

      chain.public_send(methods.last, attributes || {})
    end

    module ClassMethods
      attr_reader :render_names

      def render(*names)
        @render_names = names
      end
    end
  end
end
