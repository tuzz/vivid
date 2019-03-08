class PerspectiveCamera < Vivid::Camera
  attributes :shutteropen, :shutterclose, :frameaspectratio, :screenwindow
  render_as :camera, :perspective
  transforms :translate
end
