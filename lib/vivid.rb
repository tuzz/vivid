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

require "vivid/accelerator"
require "vivid/animation"
require "vivid/camera"
require "vivid/filter"
require "vivid/integrator"
require "vivid/light"
require "vivid/sampler"
require "vivid/shape"
require "vivid/transform_times"

Dir.glob("app/**/*.rb").each { |f| require f }

Vivid.config.path = "config/default.yml"
