class Wait < Vivid::Animation
  attr_accessor :seconds, :seconds_waited, :strategy

  def initialize(seconds)
    if seconds.is_a?(Hash)
      strategy, seconds = seconds.to_a.first
    end

    self.seconds = seconds
    self.strategy = strategy
  end

  def update(scene)
    duration = scene.frame_duration

    if seconds_waited.nil?
      self.seconds_waited = 0
    else
      self.seconds_waited += duration
    end

    if strategy == :at_most
      self.finished = seconds_waited + duration >= seconds
    else
      self.finished = seconds_waited >= seconds
    end
  end
end
