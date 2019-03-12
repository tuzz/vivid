class SpotLightingScene < Vivid::Scene
  def description
    light = SpotLight.new
    sphere = Sphere.new.translate(-1, 0, 2)

    add light
    add sphere

    play Translate.new(sphere, by: [2, 0, 0], duration: 3)
  end
end

SpotLightingScene.new.render
