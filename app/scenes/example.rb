class ExampleScene < Vivid::Scene
  def description
    add Sphere.new.translate(0, 0, 2)
    add PointLight.new

    play Wait.new(1)
  end
end

ExampleScene.new.render
