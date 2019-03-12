class AreaLightingScene < Vivid::Scene
  def description
    light = AreaLight.new(shape: Sphere.new)
      .translate(2, 0, 2)
      .scale(0.5, 0.5, 0.5)

    sphere = Sphere.new.translate(-2, 0, 2)

    add light
    add sphere

    play Translate.new(sphere, by: [0.5, 0, 0], duration: 1.5)
    play Translate.new(light, by: [-1, 1, 0], duration: 1.5)
  end
end

AreaLightingScene.new.render
