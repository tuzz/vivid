module Vivid
  class Exec
    def self.pbrt(path:)
      system("pbrt #{Config.pbrt_flags} #{path}")
    end
  end
end
