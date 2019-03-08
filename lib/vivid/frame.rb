module Vivid
  class Frame
    TEMPLATE = "frame-%08d.png"

    attr_accessor :options, :world

    def initialize(scene_options, world_definition)
      self.options = scene_options
      self.world = world_definition
    end

    def render
      pbrt_file { |f| Exec.pbrt(path: f.path) }
    end

    def set_path(namespace, frame_number)
      film.filename = "#{output_dir}/#{namespace}/#{TEMPLATE}" % frame_number
    end

    def pbrt_file
      Tempfile.create do |file|
        build_pbrt(PBRT::Builder.new(io: file))

        file.close

        yield file
      end
    end

    def build_pbrt(builder)
      options.each do |renderable|
        renderable.build_pbrt(builder)
      end

      s = self

      builder.world_begin do
        s.world.each do |renderable|
          builder.attribute_begin do
            renderable.build_pbrt(builder)
          end
        end
      end
    end

    private

    def film
      options.detect { |o| o.is_a?(Film) }
    end

    def output_dir
      Vivid.config.output
    end
  end
end
