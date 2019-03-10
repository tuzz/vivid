class Wait < Vivid::Animation
  attr_accessor :seconds, :elapsed, :strategy

  def initialize(seconds)
    if seconds.is_a?(Hash)
      strategy, seconds = seconds.to_a.first
    end

    self.seconds = seconds
    self.strategy = strategy
  end

  def update(scene)
    duration = scene.frame_duration

    if elapsed.nil?
      self.elapsed = 0
    else
      self.elapsed += duration
    end

    if strategy == :at_most
      self.finished = elapsed + duration >= seconds
    else
      self.finished = elapsed >= seconds
    end
  end
end
