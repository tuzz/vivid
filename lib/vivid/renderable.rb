module Vivid
  module Renderable
    def self.included(klass)
      klass.extend(ClassMethods)
    end

    def build_pbrt(builder)
      # [:foo, :@bar, :baz] -> [[:foo, :@bar], [:baz]]
      chunks = self.class.render_names.chunk_while do |a, b|
        b.to_s.start_with?("@")
      end

      # [[_, :@bar], _] -> [[_, :bar], _]
      chunks = chunks.map do |method, *args|
        [method, *args.map { |a| a.to_s[1..].to_sym }]
      end

      # Get the names of all arguments:
      args = chunks.flat_map { |_, *args| args }

      # [[_, :bar], _] -> [[_, "value"], _]
      chunks = chunks.map do |method, *args|
        [method, *args.map { |a| public_send(a) }]
      end

      # If the last method doesn't take a specified argument:
      unless chunks.last.size > 1

        # Set its argument to the remainder of the attributes hash:
        remainder = (attributes || {}).reject { |k, _| args.include?(k) }
        chunks.last.push(remainder)
      end

      # Call a chain of methods on the builder:
      chunks.inject(builder) do |builder, (method, *args)|
        builder.public_send(method, *args)
      end
    end

    module ClassMethods
      attr_reader :render_names

      def render_as(*names)
        @render_names = names
      end
    end
  end
end
