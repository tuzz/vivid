module Vivid
  module Renderable
    def self.included(klass)
      klass.extend(ClassMethods)
    end

    def next_frame
      @next_frame = true

      self.class.before_frame.each { |m| public_send(m) }
    end

    def build_pbrt(builder)
      unless @next_frame
        raise SequenceError, "#next_frame must be called before rendering #{self}"
      end

      self.class.before_render.each { |m| public_send(m, builder) }

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
      if chunks.last && chunks.last.size == 1

        # Set its argument to the remainder of the attributes hash:
        chunks.last << (attributes || {}).reject { |k, _| args.include?(k) }
      end

      # If the last argument is a hash:
      if chunks.last && chunks.last.last.is_a?(Hash)

        # Remove nil values:
        chunks.last.last.reject! { |_, v| v.nil? }
      end

      # Call a chain of methods on the builder:
      chunks.inject(builder) do |builder, (method, *args)|
        builder.public_send(method, *args)
      end

      self.class.after_render.each { |m| public_send(m, builder) }

      @next_frame = false
    end

    module ClassMethods
      def render_names
        @render_names ||= []
      end

      def render_as(*names)
        @render_names = names
      end

      def before_frame(*methods)
        @before_frame ||= []
        @before_frame += methods
      end

      def before_render(*methods)
        @before_render ||= []
        @before_render += methods
      end

      def after_render(*methods)
        @after_render ||= []
        @after_render += methods
      end
    end
  end

  class SequenceError < StandardError
  end
end
