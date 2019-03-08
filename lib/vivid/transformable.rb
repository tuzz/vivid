module Vivid
  module Transformable
    def self.included(klass)
      klass.extend(ClassMethods)
    end

    module ClassMethods
      attr_reader :transform_names

      def transforms(*names)
        @transform_names ||= []
        @transform_names += names

        define_translate_methods if names.include?(:translate)
        define_scale_methods if names.include?(:scale)
        define_rotate_methods if names.include?(:rotate)
      end

      def define_translate_methods
        define_method(:translate_transform) do
          @translate_transform ||= [0, 0, 0]
        end

        define_method(:translate) do |x, y, z|
          translate_transform[0] += x
          translate_transform[1] += y
          translate_transform[2] += z
        end

        define_method(:previous_translate_transform) do
          @previous_translate_transform ||= [0, 0, 0]
        end

        define_method(:flush_translation) do
          translate(*previous_translate_transform)

          @previous_translate_transform = @translate_transform
          @translate_transform = [0, 0, 0]
        end

        define_method(:render_translation) do |builder|
          unless previous_translate_transform == [0, 0, 0]
            builder.translate(previous_translate_transform)
          end

          unless translate_transform == [0, 0, 0]
            builder.active_transform(:EndTime)
            builder.translate(translate_transform)
            builder.active_transform(:All)
          end
        end

        before_frame :flush_translation if defined?(before_frame)
        before_render :render_translation if defined?(before_render)
      end

      def define_scale_methods
        define_method(:scale_transform) do
          @scale_transform ||= [1, 1, 1]
        end

        define_method(:scale) do |x, y, z|
          scale_transform[0] *= x
          scale_transform[1] *= y
          scale_transform[2] *= z
        end

        define_method(:previous_scale_transform) do
          @previous_scale_transform ||= [1, 1, 1]
        end

        define_method(:flush_scale) do
          scale(*previous_scale_transform)

          @previous_scale_transform = @scale_transform
          @scale_transform = [1, 1, 1]
        end

        define_method(:render_scale) do |builder|
          unless previous_scale_transform == [1, 1, 1]
            builder.scale(previous_scale_transform)
          end

          unless scale_transform == [1, 1, 1]
            builder.active_transform(:EndTime)
            builder.scale(scale_transform)
            builder.active_transform(:All)
          end
        end

        before_frame :flush_scale if defined?(before_frame)
        before_render :render_scale if defined?(before_render)
      end

      def define_rotate_methods
        define_method(:rotate_transform) do
          @rotate_transform ||= []
        end

        define_method(:rotate) do |degrees, x, y, z|
          previous = rotate_transform.last

          if previous && previous[1..] == [x, y, z]
            previous[0] += degrees
          else
            rotate_transform.push([degrees, x, y, z])
          end

          rotate_transform.last[0] %= 360
        end

        define_method(:previous_rotate_transform) do
          @previous_rotate_transform ||= []
        end

        define_method(:flush_rotate) do
          rotate_transform.reverse!

          previous_rotate_transform.reverse.each do |rotation|
            rotate(*rotation)
          end

          @previous_rotate_transform = rotate_transform.reverse
          @rotate_transform = []
        end

        define_method(:render_rotate) do |builder|
          unless previous_rotate_transform == []
            previous_rotate_transform.each { |r| builder.rotate(r) }
          end

          unless rotate_transform == []
            builder.active_transform(:EndTime)
            rotate_transform.each { |r| builder.rotate(r) }
            builder.active_transform(:All)
          end
        end

        before_frame :flush_rotate if defined?(before_frame)
        before_render :render_rotate if defined?(before_render)
      end
    end
  end
end
