class Rotate < Vivid::Animation
  attr_accessor :target, :degrees, :axis, :duration, :elapsed, :ease

  def initialize(target, by:, axis:, duration: 1, ease: :linear)
    self.target = target
    self.degrees = by
    self.axis = axis
    self.duration = duration
    self.elapsed = 0
    self.ease = Ease.new(ease, duration)
  end

  def update(scene)
    scene.add(target)

    previous = ease.at(elapsed)
    self.elapsed += scene.frame_duration
    current = ease.at(elapsed)

    delta = current - previous
    target.rotate(degrees * delta, *axis)

    if elapsed >= duration - EPSILON
      self.finished = true
    end
  end
end
