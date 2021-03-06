module Vivid
  class Scene
    TEMPLATE = "_%s.mp4" # At the top of directory listing.

    attr_accessor :options, :world, :animations, :frame_number

    def initialize
      self.options = {}
      self.world = {}
      self.animations = []
      self.frame_number = 0

      set_options_from_config
    end

    def name
      self.class.name.split("::").last
    end

    def description
      raise NotImplementedError
    end

    def set(object)
      options[object.option_type] = object
      object.next_frame
    end

    def add(object)
      return if world.key?(object) || object.respond_to?(:option_type)

      world[object] = true
      object.next_frame
    end

    def play(animation)
      animations << animation
    end

    def render
      description

      remove_stale_directory

      until finished?
        next_frame
        update_animation
        render_frame
      end

      stitch_frames
    end

    def remove_stale_directory
      FileUtils.rm_rf(Frame.directory(self.name))
    end

    def finished?
      animations.empty?
    end

    def next_frame
      self.frame_number += 1

      options.values.each(&:next_frame)
      world.keys.each(&:next_frame)
    end

    def update_animation
      return if finished?

      animation = animations.first
      animation.update(self)

      if animation.finished?
        animations.shift
        update_animation
      end
    end

    def render_frame
      frame = Frame.new(options.values, world.keys)
      frame.set_path(self.name, frame_number)
      frame.render
    end

    def stitch_frames
      input = Frame.template(name)
      output = [Frame.directory(name), TEMPLATE % name].join("/")

      Exec.ffmpeg(input: input, output: output, rate: frame_rate)
    end

    def set_options_from_config
      set TransformTimes.from_config
      set Camera.from_config
      set Sampler.from_config
      set Film.from_config
      set Filter.from_config
      set Integrator.from_config
      set Accelerator.from_config
    end

    def frame_rate
      options.fetch(:transform_times).frame_rate
    end

    def frame_duration
      options.fetch(:transform_times).frame_duration
    end
  end
end
