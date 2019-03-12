class DistantLightingScene < Vivid::Scene
  def description
    # Blue light going down:
    light1 = DistantLight.new(L: rgb(0.5, 0.5, 1), to: [0, -1, 0])

    # Yellow light going left:
    light2 = DistantLight.new(L: rgb(1, 1, 0.5), to: [-1, 0, 0])

    sphere = Sphere.new.translate(-1, 0, 2)

    add light1
    add light2

    play Translate.new(sphere, by: [2, 0, 0], duration: 2)
  end
end

DistantLightingScene.new.render
