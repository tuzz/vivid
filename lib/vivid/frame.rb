module Vivid
  class Frame
    attr_accessor :options, :world

    def initialize(scene_options, world_definition)
      self.options = scene_options
      self.world = world_definition
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
  end
end
