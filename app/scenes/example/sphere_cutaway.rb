class SphereCutaway < Vivid::Scene
  def description
    sphere = Sphere.new(zmin: -0.95, zmax: -0.8, phimax: 330)
      .translate(-1, 0, 2)

    light = PointLight.new.translate(0, 1, 0)

    add light
    play Translate.new(sphere, by: [2, 0, 0], duration: 3)
  end
end

SphereCutaway.new.render
