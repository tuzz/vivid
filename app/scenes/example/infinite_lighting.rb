class InfiniteLightingScene < Vivid::Scene
  def description
    light = InfiniteLight.new(L: rgb(0.1, 0.1, 0.1))

    sphere = Sphere.new.translate(-1, 0, 2)

    add light
    add sphere

    play  Translate.new(sphere, by: [2, 0, 0], duration: 3)
  end
end

InfiniteLightingScene.new.render
