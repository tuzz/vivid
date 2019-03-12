class TriforceScene < Vivid::Scene
  def description
    points =
      5.times.flat_map do |y|
        5.times.map do |x|
          [x - 2, y - 2, 3]
        end
      end

    indices = [
      [0, 2, 11],    # bottom-left triangle
      [2, 4, 13],    # bottom-right triangle
      [11, 13, 22],  # top triangle
    ]

    triforce = TriangleMesh.new(P: points, indices: indices)

    orb = AreaLight.new(shape: Sphere.new, L: rgb(3, 0, 0))
      .scale(0.2, 0.2, 0.2)
      .translate(0.8, -0.5, 1)

    add PointLight.new(I: rgb(10, 10, 0))

    play Simultaneous.new(
      Rotate.new(triforce, by: 360, axis: [0, 0, 1], duration: 5),
      Translate.new(orb, by: [-1.6, 1, 0], duration: 5),
      Scale.new(orb, by: [1.5, 1.5, 1.5], duration: 5),
    )
  end
end

TriforceScene.new.render
