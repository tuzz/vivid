class Appear < Vivid::Animation
  attr_accessor :target

  def initialize(target)
    self.target = target
  end
end
