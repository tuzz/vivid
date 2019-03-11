class RotateScene < Vivid::Scene
  def description
    cone = Cone.new(height: 2)
      .translate(0, 0, 2)
      .rotate(90, 0, 1, 0)
      .rotate(-90, 1, 0, 0)

    add cone
    add PointLight.new.translate(0, 1, 0)

    play Rotate.new(cone, by: 540, axis: [1, 0, 0], duration: 2)
  end
end

RotateScene.new.render
