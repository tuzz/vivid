class SimultaneousScene < Vivid::Scene
  def description
    light1 = InfiniteLight.new(L: rgb(0.1, 0.1, 0.1))
    light2 = PointLight.new(I: rgb(5, 5, 5)).translate(-2, 1, 0)

    sphere = Sphere.new.translate(-1, 0, 2)
    sphere.material = Matte.new(Kd: rgb(1, 0, 0))

    cone = Cone.new.rotate(-90, 1, 0, 0).translate(1, 0, 2)
    cone.material = Matte.new(Kd: rgb(0, 0, 1))

    add light1

    play Simultaneous.new(
      Translate.new(sphere, by: [0, 0.5, 0], duration: 4),
      Translate.new(cone, by: [0, -0.5, 0], duration: 4),
      Scale.new(sphere, by: [0.5, 1, 1.2], duration: 2),
      Translate.new(light2, by: [4, 0, 0], duration: 3),
    )
  end
end

SimultaneousScene.new.render
