$LOAD_PATH.push(".")

require "pbrt"

Dir.glob("{lib,app}/**/*.rb").each { |f| require f }
