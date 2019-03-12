class ConeCutawayScene < Vivid::Scene
  def description
    cone = Cone.new(height: 2, phimax: 330)
      .rotate(-90, 1, 0, 0)
      .rotate(60, 0, 0, 1)
      .translate(-1, -0.75, 2)

    add PointLight.new(I: rgb(5, 5, 5)).translate(0, 1, 0)
    play Translate.new(cone, by: [2, 0, 0], duration: 3)
  end
end

ConeCutawayScene.new.render
