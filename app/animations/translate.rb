class Translate < Vivid::Animation
  attr_accessor :target, :vector, :duration, :elapsed, :ease

  def initialize(target, by:, duration: 1, ease: :linear)
    self.target = target
    self.vector = by
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

    target.translate(
      vector[0] * delta,
      vector[1] * delta,
      vector[2] * delta,
    )

    if elapsed >= duration - EPSILON
      self.finished = true
    end
  end
end
