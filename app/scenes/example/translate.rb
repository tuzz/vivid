class TranslateScene < Vivid::Scene
  def description
    add (sphere = Sphere.new.translate(-1, 0, 2))
    add PointLight.new.translate(0, 1, 0)

    play Translate.new(sphere, by: [2, 0, 0], duration: 2)
  end
end

TranslateScene.new.render
