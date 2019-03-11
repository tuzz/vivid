class ScaleScene < Vivid::Scene
  def description
    add (sphere = Sphere.new.translate(0, 0, 2))
    add PointLight.new.translate(0, 1, 0)

    play Scale.new(sphere, by: [0.5, 1.5, 1], duration: 2)
  end
end

ScaleScene.new.render
