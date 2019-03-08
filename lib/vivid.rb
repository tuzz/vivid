$LOAD_PATH.push(".")

require "pbrt"

require "vivid/attributes"
require "vivid/renderable"
require "vivid/transformable"

require "vivid/shape"

Dir.glob("app/**/*.rb").each { |f| require f }
