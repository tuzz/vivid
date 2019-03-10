class EnvironmentCamera < Vivid::Camera
  attributes :shutteropen, :shutterclose, :frameaspectratio, :screenwindow
  render_as :camera, :environment
  transforms :translate
end
