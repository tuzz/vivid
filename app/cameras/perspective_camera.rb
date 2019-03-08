class PerspectiveCamera < Vivid::Camera
  attributes :frameaspectratio, :screenwindow
  render_as :camera, :perspective
end
