$LOAD_PATH.push(".")

require "pbrt"
require "tempfile"
require "yaml"

require "vivid/attributes"
require "vivid/renderable"
require "vivid/transformable"

require "vivid/config"
require "vivid/exec"
require "vivid/frame"
require "vivid/scene"

require "vivid/camera"
require "vivid/light"
require "vivid/shape"

Dir.glob("app/**/*.rb").each { |f| require f }

Vivid.config.path = "config/default.yml"
