class SphereFlybyScene < Vivid::Scene
  def description
    camera = PerspectiveCamera.new(fov: 55)

    set camera

    sphere1 = Sphere.new.scale(2, 2, 2).translate(-1, 4, 15)
    sphere1.material = Metal.new

    sphere2 = Sphere.new.scale(5, 5, 5).translate(2, 2, 20)
    sphere2.material = Plastic.new(Kd: rgb(0.2, 1.0, 0.2))

    sphere3 = Sphere.new.scale(3, 3, 3).translate(10, -1, 25)
    sphere3.material = Plastic.new(Kd: rgb(0.5, 0, 0.7))

    sphere4 = Sphere.new.scale(2, 2, 2).translate(12, 4, 24)
    sphere4.material = Matte.new(Kd: rgb(1, 1, 0.2))

    sphere5 = Sphere.new.scale(3, 3, 3).translate(-5, -2, 12)
    sphere5.material = Plastic.new(Kd: rgb(0, 0.2, 0.8))

    sphere6 = Sphere.new.scale(1, 1, 1).translate(-1, -1, 11)
    sphere6.material = Glass.new

    sphere7 = Sphere.new.scale(4, 4, 4).translate(-11, 6, 12)
    sphere7.material = Plastic.new(Kd: rgb(1, 1, 1))

    sphere8 = Sphere.new.scale(5, 5, 5).translate(6, -9, 12)
    sphere8.material = Plastic.new(Kd: rgb(0, 0, 0))

    light1 = PointLight.new(I: rgb(300, 300, 300)).translate(-3, 12, -2)
    light2 = PointLight.new(I: rgb(200, 200, 200)).translate(12, 12, 22)
    light3 = PointLight.new(I: rgb(100, 100, 100)).translate(-5, 8, 30)
    light4 = InfiniteLight.new(L: rgb(0.1, 0.15, 0.2))
    light5 = DistantLight.new(L: rgb(5, 4, 2), to: [1, -1, 0])

    light6 = ProjectionLight.new(mapname: "/vivid/app/assets/images/cc-logo.png", I: rgb(100, 100, 100))
      .translate(0, 1, 10)

    add sphere1
    add sphere2
    add sphere3
    add sphere4
    add sphere5
    add sphere6
    add sphere7
    add sphere8

    add light1
    add light2
    add light3
    add light4
    add light5
    add light6

    play Simultaneous.new(
      Translate.new(camera, by: [0, 0, -15], duration: 10, ease: :in_out_sine),
      Rotate.new(camera, by: 45, axis: [0, 0, 1], duration: 10, ease: :in_out_sine),
      Rotate.new(light6, by: 1080, axis: [0, 1, 0], duration: 10),
      Scale.new(sphere1, by: [2, 0.5, 1], duration: 10),
      Scale.new(sphere2, by: [0.3, 1, 1], duration: 10),
      Translate.new(sphere3, by: [0, -1, 0], duration: 10),
      Translate.new(sphere7, by: [5, 0, 5], duration: 10),
      Scale.new(sphere7, by: [0.3, 0.3, 0.3], duration: 10),
      Translate.new(sphere8, by: [-5, 0, 15], duration: 10),
      Translate.new(sphere4, by: [-15, 0, 0], duration: 10),
    )

    play Translate.new(camera, by: [0, 0, 20], duration: 3, ease: :in_sine)
  end
end

SphereFlybyScene.new.render
