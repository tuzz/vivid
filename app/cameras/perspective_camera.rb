class PerspectiveCamera < Vivid::Camera
  attributes(
    :shutteropen,
    :shutterclose,
    :frameaspectratio,
    :screenwindow,
    :lensradius,
    :focaldistance,
    :fov,
    :halffov,
  )

  render_as :camera, :perspective
  transforms :translate, :rotate
end
