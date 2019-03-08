class OrthographicCamera < Vivid::Camera
  attributes(
    :shutteropen,
    :shutterclose,
    :frameaspectratio,
    :screenwindow,
    :lensradius,
    :focaldistance,
  )

  render_as :camera, :perspective
  transforms :translate
end
