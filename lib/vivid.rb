$LOAD_PATH.push(".")

require "pbrt"
require "tempfile"
require "yaml"
require "easing"

require "vivid/mixins/attributes"
require "vivid/mixins/materialistic"
require "vivid/mixins/renderable"
require "vivid/mixins/transformable"

require "vivid/pbrt/accelerator"
require "vivid/pbrt/camera"
require "vivid/pbrt/film"
require "vivid/pbrt/filter"
require "vivid/pbrt/integrator"
require "vivid/pbrt/light"
require "vivid/pbrt/material"
require "vivid/pbrt/sampler"
require "vivid/pbrt/shape"
require "vivid/pbrt/texture"
require "vivid/pbrt/transform_times"

require "vivid/rendering/cache"
require "vivid/rendering/frame"
require "vivid/rendering/scene"

require "vivid/animation"
require "vivid/cli"
require "vivid/config"
require "vivid/exec"
require "vivid/global"

require "ease"

Vivid.config.path = "config/default.yml"

Dir.glob("app/**/*.rb").each do |file|
  require file unless file.start_with?("app/scenes")
end
