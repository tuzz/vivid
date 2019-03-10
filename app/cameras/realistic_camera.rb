class RealisticCamera < Vivid::Camera
  attributes(
    :shutteropen,
    :shutterclose,
    :lensfile,
    :aperturediameter,
    :focusdistance,
    :simpleweighting,
  )

  render_as :camera, :realistic
  transforms :translate
end
