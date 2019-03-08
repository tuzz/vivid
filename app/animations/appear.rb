class Appear < Vivid::Animation
  attr_accessor :target

  def initialize(target)
    self.target = target
  end

  def update(scene)
    scene.add(target)

    self.finished = true
  end
end
