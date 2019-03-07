module Vivid
  module Transformable
    def self.included(klass)
      klass.extend(ClassMethods)
    end

    module ClassMethods
      attr_reader :transfom_names

      def transforms(*names)
        @transfom_names = names

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

        define_method(:render_translation) do |builder|
          builder.translate(translate_transform)
        end

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

        define_method(:render_scale) do |builder|
          builder.scale(scale_transform)
        end

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

        define_method(:render_rotate) do |builder|
          rotate_transform.each do |rotation|
            builder.rotate(rotation)
          end
        end

        before_render :render_rotate if defined?(before_render)
      end
    end
  end
end
