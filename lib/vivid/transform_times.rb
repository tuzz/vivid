module Vivid
  class TransformTimes
    include Attributes
    include Renderable

    def option_type
      :transform_times
    end

    attributes :frame_rate
    render_as :transform_times, :@start_time, :@end_time

    def start_time
      0
    end

    def end_time
      1.0 / frame_rate
    end

    alias :frame_duration :end_time

    def self.from_config
      new(frame_rate: Vivid.config.frame_rate)
    end
  end
end
