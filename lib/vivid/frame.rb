module Vivid
  class Frame
    TEMPLATE = "frame-%08d.png"

    def self.template(namespace)
      [self.directory(namespace), TEMPLATE].join("/")
    end

    def self.directory(namespace)
      [Vivid.config.output, namespace].join("/")
    end

    attr_accessor :options, :world

    def initialize(scene_options, world_definition)
      self.options = scene_options
      self.world = world_definition
    end

    def render
      ensure_directory_exists

      pbrt_file { |f| Exec.pbrt(path: f.path) }
    end

    def set_path(namespace, frame_number)
      film.filename = self.class.template(namespace) % frame_number
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

    def ensure_directory_exists
      FileUtils.mkdir_p(File.dirname(film.filename))
    end

    def film
      options.detect { |o| o.is_a?(Film) }
    end
  end
end
