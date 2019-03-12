class Simultaneous < Vivid::Animation
  attr_accessor :animations

  def initialize(*animations)
    self.animations = animations
  end

  def update(scene)
    animations.each { |a| a.update(scene) }
    animations.delete_if(&:finished?)
  end

  def finished?
    animations.empty?
  end
end
